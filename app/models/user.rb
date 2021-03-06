class User < ApplicationRecord
  include TimeHelper

  has_secure_password :validations => false
  has_many :skills
  has_many :goals, through: :skills
  has_many :sessions, through: :skills
  has_many :user_followers
  has_many :followers, through: :user_followers


  def most_recent_sessions
    sessions.order('sessions.created_at DESC').limit(10)
  end

  def num_users_following
    User.joins(:user_followers).where("user_followers.follower_id = #{self.id}").count
  end

  def users_following
    User.joins(:user_followers).where("user_followers.follower_id = #{self.id}")
  end

  def following?(user)
     where("user_followers.user_id = #{user.id}").empty? ? false : true
  end

  def current_goals
    goals.where('goals.week_number = ?', current_week)
  end

  def next_week_goals
    goals.where('goals.week_number = ?', next_week)
  end

  def current_sessions
    sessions.where('extract(week from sessions.created_at) = ?', current_week)
  end

  def skill_form_options
    skills.pluck(:nickname, :id)
  end

  def session_form_options
    skills =  self.skills.select("skills.*")
                  .joins(:goals)
                  .where('goals.week_number = ?', current_week)
                  .distinct
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

  def points(points=0)
    points += goals.count
    points += sessions.sum(:duration)/6
  end

  def current_week_points
    current_sessions.sum(:duration)/6
  end

  def level
    (points/100).round
  end

  def self.get_credentials_for_cli(nickname, password)
    user = User.find_by(nickname: nickname)
    if user && user.authenticate(password)
      {"id" => user.id, "quiz_id" => user.quiz_id, "quiz_token" => user.quiz_token}
    else
      {"id" => "User not found", "quiz_id" => "User not found", "quiz_token" => "User not found"}
    end
  end

end
