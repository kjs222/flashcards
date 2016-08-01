class Session < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :skill

  def username
    skill.user.name
  end

  def self.data_for_charts(time_period)
    sessions = self.sessions_for_charts(time_period.to_i)
    sessions.get_data_for_charts(time_period.to_i)
  end

  def self.get_data_for_charts(time_period)
    time_period == 52 ? self.get_data_by_month : self.get_data_by_day
  end

  def self.get_data_by_month
    data = group_by_month(:created_at, format: "%B %Y").sum(:duration)
    [data.keys, data.values]
  end

  def self.get_data_by_day
    data = group_by_day(:created_at, format: '%B %d').sum(:duration)
    [data.keys, data.values]
  end


  def self.sessions_for_charts(time_period)
    where(created_at: time_period.weeks.ago..Time.now)
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
  def self.time_series_session_data(start_date, end_date, interval)

    result = ActiveRecord::Base.connection.exec_query("SELECT
        date_trunc('#{interval}', date) as period,
        coalesce(minutes,0) AS minutes
      FROM
        generate_series(
          '#{start_date}'::date,
          '#{end_date}'::date,
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
       ON (date = results.period)")
      result.to_hash
  end

  # def self.test_sql
  #   result = ActiveRecord::Base.connection.exec_query("SELECT
  #       date,
  #       coalesce(sum,0) AS sum
  #     FROM
  #       generate_series(
  #         '2016-07-20 00:00'::timestamp,
  #         '2016-08-01 00:00'::timestamp,
  #         '1 day') AS date
  #     LEFT OUTER JOIN
  #     (SELECT
  #        date_trunc('day', sessions.created_at) as day,
  #        sum(sessions.duration) as sum
  #      FROM sessions
  #      WHERE
  #        created_at >= '2016-07-20 00:00'
  #        AND created_at < '2016-08-09 00:00'
  #        GROUP BY day) results
  #      ON (date = results.day)")
  #   result.to_hash
  # end

end
