class User < ApplicationRecord
  has_secure_password :validations => false

  def self.from_omniauth(auth_info)

    where(uid: auth_info['uid']).first_or_create do |user|
      user.uid = auth_info["uid"]
      user.token = auth_info["credentials"]["token"]
    end
  end

  def self.get_credentials_for_cli(uid, password)
    user = User.find_by(uid: uid)
    if user && user.authenticate(password)
      {"uid" => uid, "token" => user.token}
    else
      {"uid" => "User not found", "token" => "User not found"}
    end
  end

end
