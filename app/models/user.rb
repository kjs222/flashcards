class User < ApplicationRecord
  has_secure_password :validations => false
  has_many :skills
  has_many :goals, through: :skills
  has_many :sessions, through: :skills


  def current_goals
    goals.where('goals.week_number = ?', current_week)
  end

  def next_week_goals
    goals.where('goals.week_number = ?', current_week + 1)
  end

  def current_sessions
    sessions.where('extract(week from sessions.created_at) = ?', current_week)
  end

  #move these to presenters
  def skill_form_options
    skills.pluck(:nickname, :id)
  end

  def session_form_options
    # byebug
    skills = self.skills.select("skills.*").joins(:goals).where('goals.week_number = ?', current_week).distinct
    skills.pluck(:nickname, :id)
  end

  def self.github_from_omniauth(auth_info)
    where(gh_uid: auth_info['uid']).first_or_create do |user|
      user.gh_uid = auth_info["uid"]
      user.name = auth_info["info"]["name"]
      user.gh_token = auth_info["credentials"]["token"]
      user.nickname = auth_info["info"]["nickname"]
      user.image = auth_info["extra"]["raw_info"]["avatar_url"]
      user.email = auth_info["info"]["email"]
    end
  end

  def add_quizlet_credentials(auth_info)
    update_attributes(quiz_id: auth_info["uid"], quiz_token:auth_info["credentials"]["token"])
  end

  def current_week
    current_week = Date.today.cweek
  end


  #does this belong here or somewhere else?:
  def self.get_credentials_for_cli(nickname, password)
    user = User.find_by(nickname: nickname)
    if user && user.authenticate(password)
      {"uid" => user.quiz_id, "token" => user.quiz_token}
    else
      {"uid" => "User not found", "token" => "User not found"}
    end
  end

end
