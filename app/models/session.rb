class Session < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :skill
end
