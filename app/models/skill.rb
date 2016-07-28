class Skill < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :user
  has_many :goals
  has_many :sessions
  validates :nickname, uniqueness: true

  def username
    user.name
  end

end
