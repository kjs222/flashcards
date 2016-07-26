class User < ApplicationRecord
  has_secure_password :validations => false

  def self.github_from_omniauth(auth_info)
    where(gh_uid: auth_info['uid']).first_or_create do |user|
      user.gh_uid = auth_info["uid"]
      user.name = auth_info["info"]["name"]
      user.gh_token = auth_info["credentials"]["token"]
      user.nickname = auth_info["info"]["nickname"]
      user.email = auth_info["info"]["email"]
    end
  end


  # def self.from_omniauth(auth_info)
  #
  #   where(uid: auth_info['uid']).first_or_create do |user|
  #     user.uid = auth_info["uid"]
  #     user.token = auth_info["credentials"]["token"]
  #   end
  # end

  def self.get_credentials_for_cli(uid, password)
    user = User.find_by(uid: uid)
    if user && user.authenticate(password)
      {"uid" => uid, "token" => user.token}
    else
      {"uid" => "User not found", "token" => "User not found"}
    end
  end

end
