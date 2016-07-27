class Dashboard

  attr_reader :skills

  def initialize(user)
    @skills = user.skills
  end

end
