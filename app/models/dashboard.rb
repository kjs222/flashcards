class Dashboard

  attr_reader :skills, :current_goals, :next_goals, :sessions

  def initialize(user)
    @user = user
    @skills = user.skills
    @current_goals = user.current_goals
    @next_goals = user.next_week_goals
    @sessions = user.current_sessions
  end

end
