class Quizlet < OpenStruct
  def self.service(user)
    @@service ||= QuizletService.new(user)
  end

  def self.sets(current_user)
    raw_sets = service(current_user).get_sets
    sets = raw_sets.map {|set| Quizlet.new(set)}
  end

end
