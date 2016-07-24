class User < ApplicationRecord
  has_secure_password

  def self.from_omniauth(auth_info)
    where(uid: auth_info['uid']).first_or_create do |user|
      user.uid = auth_info["uid"]
      user.token = auth_info["credentials"]["token"]
    end
  end

  def self.get_token_for_cli(uid, password)
    user = User.find_by(uid: uid)
    if user && user.authenticate(password)
      {"token" => user.token}
    else
      {"token" => "User not found"}
    end
  end

end
