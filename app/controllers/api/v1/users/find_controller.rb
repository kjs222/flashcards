class Api::V1::Users::FindController < ApplicationController

  def show
    @user = User.find_by(nickname: params[:user_nickname])
    if @user
      render json: @user
    else
      render json: {
        error: "User not found",
        status: 400
        }, status: 400
    end
  end

end
