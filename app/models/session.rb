class Session < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :skill

  def username
    skill.user.name
  end

  def self.data_for_charts(time_period)
    sessions = self.sessions_for_charts(time_period)
    sessions.get_data_for_charts(time_period)
  end

  def self.get_data_for_charts(time_period)
    time_period == 52 ? self.get_data_by_month : self.get_data_by_day
  end

  def self.get_data_by_month
    group_by_month(:created_at, format: "%B %Y").sum(:duration)
    #format is: {"July 2016"=>120}
  end

  def self.get_data_by_day
    group_by_day(:created_at, format: '%B %d').sum(:duration)
    #format is: {"July 28"=>60, "July 29"=>60}
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

end
