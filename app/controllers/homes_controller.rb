class HomesController<ApplicationController

  def show
    if current_user
      redirect_to dashboard_index_path 
    else
      render :show
    end
  end



end
