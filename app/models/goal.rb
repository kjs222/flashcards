class Goal < ApplicationRecord
  include PublicActivity::Model
  tracked owner: :user
  belongs_to :skill
  delegate :user, to: :skill

  
  validates :skill_id, presence: true


  def username
    skill.user.name
  end

  def self.available_points
    sum("num_sessions * session_length")/6
  end

end
