class QuizSet < OpenStruct
  def self.service(user)
    @@service ||= QuizletService.new(user)
  end

  def self.sets(current_user)
    raw_sets = service(current_user).get_sets
    sets = raw_sets.map {|set| QuizSet.new(set)}
  end


end
