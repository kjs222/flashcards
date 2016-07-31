class Api::V1::Sessions::CliController < ApplicationController

  def create
    skill = set_skill
    if skill
      session = Session.create(skill_id: skill.id, duration: 30)
      response = {response: "Session started"}
    else
      response = {response: "Skill not found"}
    end
    render json: response
  end

  def update
    session_to_end = Session.find_recent_by_skill(set_skill) if set_skill
    if session_to_end
      duration = session_to_end.calculate_duration
      session_to_end.update_attributes(duration: duration)
      response = {response: "Session ended. Total practice time: #{duration} minutes"}
    else
      response = {response: "Session not found"}
    end
    render json: response
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :skill_name)
  end

  def set_skill
    user = User.find(session_params[:user_id])
    user.skills.find_by(nickname: session_params[:skill_name])
  end


end
