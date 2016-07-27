class Skill < ApplicationRecord
  belongs_to :user
  has_many :goals
  validates :nickname, uniqueness: true

end
