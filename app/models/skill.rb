class Skill < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :user
  has_many :goals
  has_many :sessions
  validates :nickname, presence: true
  

  def username
    user.name
  end

  def num_sessions
    sessions.count
  end

  def total_practice_time
    sessions.sum(:duration)
  end

  def points_earned
    total_practice_time/6
  end

  def last_practiced_date
    sessions.order('created_at DESC').pluck(:created_at).first
  end

end
