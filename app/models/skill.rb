class Skill < ApplicationRecord
  belongs_to :user
  has_many :goals
  has_many :sessions
  validates :nickname, uniqueness: true

end
