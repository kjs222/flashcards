class QuizletService

  def initialize(user)
    @user = user
    @connection = Faraday.new('https://api.quizlet.com')
    @connection.headers["Authorization"] = "Bearer #{@user.token}"
  end

  def get_sets
    response = @connection.get("/2.0/users/#{@user.uid}/sets")
    parse(response)
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
