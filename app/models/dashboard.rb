class Dashboard

  attr_reader :skills, :goals

  def initialize(user)
    @skills = user.skills
    @goals = user.active_goals
  end

end
