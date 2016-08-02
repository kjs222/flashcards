class SearchController<ApplicationController

  def index
    @search_results = Quizlet.search_results(current_user, params[:q], params[:created_by])
  end

  private

  def search_params
    params.permit(:q, :created_by)
  end

end
