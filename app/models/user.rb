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

  def add_quizlet_credientials_to_account(auth_info)
    update_attributes(quiz_id: auth_info["uid"], quiz_token:auth_info["credentials"]["token"])
  end


  # def self.from_omniauth(auth_info)
  #
  #   where(uid: auth_info['uid']).first_or_create do |user|
  #     user.uid = auth_info["uid"]
  #     user.token = auth_info["credentials"]["token"]
  #   end
  # end
  #decide if nickname or quiz
  def self.get_credentials_for_cli(nickname, password)
    user = User.find_by(nickname: nickname)
    #NEED to handle if quiz values are nil
    if user && user.authenticate(password)
      {"uid" => user.quiz_id, "token" => user.quiz_token}
    else
      {"uid" => "User not found", "token" => "User not found"}
    end
  end

end
