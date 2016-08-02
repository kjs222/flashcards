class Quizlet < OpenStruct
  def self.service(user)
    @@service ||= QuizletService.new(user)
  end

  def self.sets(user)
    raw_sets = service(user).get_sets
    raw_sets.map {|set| Quizlet.new(set)}
  end

  def self.search_results(user, searched_term, searched_created_by)
    raw_sets = service(user).get_search_results(searched_term, searched_created_by)
    raw_sets.map {|set| Quizlet.new(set)}
  end


end
