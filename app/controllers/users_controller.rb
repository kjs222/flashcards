class UsersController < ApplicationController

  def show
    @user = User.find_by(nickname: params[:nickname])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Command Line App is Enabled"
      redirect_to account_path
    else
      render :edit
    end
  end

  def add_quizlet
    current_user.add_quizlet_credentials(request.env["omniauth.auth"])
    redirect_to account_path
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end



end
