class Dashboard

  attr_reader :skills, :current_goals, :next_goals

  def initialize(user)
    @skills = user.skills
    @current_goals = user.current_goals
    @next_goals = user.next_week_goals
  end

end
