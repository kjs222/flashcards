class QuizletTerm < OpenStruct
  def self.service(user)
    @@service ||= QuizletService.new(user)
  end

  def self.terms(current_user, set_id)
    raw_terms = service(current_user).get_terms(set_id)
    terms = raw_terms.map {|term| QuizletTerm.new(term)}
  end

end
