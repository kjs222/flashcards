class Session < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :skill

  def username
    skill.user.name
  end

  def self.data_for_charts(user, time_period)
    sessions = sessions_for_charts(user, time_period.to_i)
    sessions.get_data_for_charts(time_period.to_i)
  end

  def self.get_data_for_charts(time_period)
    interval = time_period == 52 ? "month" : "day"
    start_date = time_period.weeks.ago
    time_series_session_data(start_date, Time.now.utc, interval)
  end

  def self.time_series_session_data(start_date, end_date, interval)
    result = ActiveRecord::Base.connection.exec_query("SELECT
        date_trunc('#{interval}', date) as period,
        coalesce(minutes,0) AS minutes
      FROM
        generate_series(
          date_trunc('#{interval}', '#{start_date}'::date),
          date_trunc('#{interval}', '#{end_date}'::date),
          '1 #{interval}') AS date
      LEFT OUTER JOIN
      (SELECT
         date_trunc('#{interval}', sessions.created_at) as period,
         sum(sessions.duration) as minutes
       FROM sessions
       WHERE
         created_at >= '#{start_date}'
         AND created_at <= '#{end_date}'
         GROUP BY period) results
       ON (date = results.period)").rows
    [get_dates(result, interval), get_values(result)]
  end

  def self.sessions_for_charts(user, time_period)
    # where(created_at: time_period.weeks.ago..Time.now)
    joins(:skill).where('skills.user_id = ?', user.id).where('sessions.created_at > ? AND sessions.created_at <= ?', time_period.weeks.ago, Time.now)
  end

  def self.find_recent_by_skill(skill)
    joins(:skill)
      .where('skills.id = ?', skill.id)
      .where('sessions.created_at > ?', 75.minutes.ago)
      .order('sessions.created_at DESC')
      .limit(1).first
  end

  def calculate_duration
    ((Time.now - created_at)/60).round
  end

  def self.get_dates(date_value_pairs, interval)
    date_format = interval == "month" ? '%B %Y' : '%b %d'
    dates = date_value_pairs.map do |data_point|
      Date.parse(data_point.first).strftime(date_format)
    end
  end

  def self.get_values(date_value_pairs)
    date_value_pairs.map {|data_point| data_point.last}
  end


end
