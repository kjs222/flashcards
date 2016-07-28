class QuizletService

  def initialize(user)
    @user = user
    @connection = Faraday.new('https://api.quizlet.com')
    @connection.headers["Authorization"] = "Bearer #{@user.quiz_token}"
  end

  def get_sets
    response = @connection.get("/2.0/users/#{@user.quiz_id}/sets")
    parse(response)
  end

  def get_terms(set_id)
    response = @connection.get("/2.0/sets/#{set_id}/terms")
    parse(response)
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
