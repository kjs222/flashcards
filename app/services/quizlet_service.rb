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

  def get_terms(set_id)
    response = @connecton.get("/2.0/sets/#{set_id}/terms")
    parse(response)
    binding.pry
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
