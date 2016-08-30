class QuizletService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new('https://api.quizlet.com')
    @connection.headers["Authorization"] = "Bearer #{@user.quiz_token}"
  end

  def get_sets
    # Rails.cache.fetch("user-#{@user.id}-api-quizsets", expires_in: 10.minutes) do
      response = @connection.get("/2.0/users/#{user.quiz_id}/sets")
      parse(response)
    # end
  end


  def get_terms(set_id)
    response = @connection.get("/2.0/sets/#{set_id}/terms")
    parse(response)
  end

  def get_search_results(search_terms)
    if search_terms[:created_by] && search_terms[:q].empty?
      response = @connection.get("/2.0/users/#{search_terms[:created_by]}/sets")
      parse(response)
    else
      response =  @connection.get("/2.0/search/sets",
                  {q: search_terms[:q],
                  creator: search_terms[:created_by]})
      parse(response)["sets"]
    end
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

end
