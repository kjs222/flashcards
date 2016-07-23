class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(uid: auth_info['uid']).first_or_create do |user|
      user.uid = auth_info["uid"]
      user.token = auth_info["credentials"]["token"]
    end
  end

end
