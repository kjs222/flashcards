class SessionsController < ApplicationController

  def create
    # byebug
    render text: request.env["omniauth.auth"].inspect
  end


end
