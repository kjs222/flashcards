class Api::V1::SessionsController < ApplicationController

  def create
    session = Session.create(session_params)
    skill = session.skill
    render json: [session, skill]
  end

  private

  def session_params
    params.require(:session).permit(:skill_id, :duration)
  end


end
