class QuizletController<ApplicationController

  def index
    @quizsets = Quizlet.sets(current_user)
  end


end
