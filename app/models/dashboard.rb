class Dashboard

  attr_reader :skills, :current_goals, :next_goals, :sessions

  def initialize(user)
    @user = user
    @skills = user.skills
    @current_goals = user.current_goals
    @next_goals = user.next_week_goals
    @sessions = user.current_sessions
  end

  def current_week_points_available
    @current_goals.sum("num_sessions * session_length")/6
  end

  def next_week_points_available
    @next_goals.sum("num_sessions * session_length")/6
  end


end
