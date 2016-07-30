class Api::V1::Sessions::CliController < ApplicationController

  def create
    user = User.find(session_params[:user_id])
    skill = user.skills.find_by(nickname: session_params[:skill_name])
    if skill
      session = Session.create(skill_id: skill.id, duration: 30)
      response = {response: "Session started"}
    else
      response = {response: "Skill not found"}
    end
    render json: response
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :skill_name, :type)
  end


end
