class UserFollower < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: User


  def self.first_by_follower(follower_id)
    find_by(follower_id: follower_id)
  end

end
