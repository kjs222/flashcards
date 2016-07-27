class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Your updates have been saved"
      redirect_to root_path
    else
      flash.now[:warning] = @user.errors.full_messages.join(", ")
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
