class Goal < ApplicationRecord
  include PublicActivity::Model
  tracked
  belongs_to :skill

  def username
    skill.user.name
  end

end
