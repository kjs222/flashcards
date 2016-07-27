class Skill < ApplicationRecord
  belongs_to :user
  validates :nickname, uniqueness: true

end
