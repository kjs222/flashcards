class QuizletService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new('https://api.quizlet.com')
    @connection.headers["Authorization"] = "Bearer #{@user.quiz_token}"
  end

  def get_sets
    Rails.cache.fetch("user-#{@user.id}-api-quizsets", expires_in: 10.minutes) do
      response = @connection.get("/2.0/users/#{user.quiz_id}/sets")
      parse(response)
    end
  end


  def get_terms(set_id)
    response = @connection.get("/2.0/sets/#{set_id}/terms")
    parse(response)
  end

  def get_search_results(searched_term, searched_created_by)
    response =  @connection.get("/2.0/search/sets", {q: searched_term,
                creator: searched_created_by})
    parse(response)["sets"]
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
