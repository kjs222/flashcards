class Api::V1::UsersController < ApplicationController

  def show
    credentials = User.get_credentials_for_cli(user_params[:nickname], user_params[:password])
    render json: credentials
  end

  private

  def user_params
    params.permit(:nickname, :password)
  end


end
