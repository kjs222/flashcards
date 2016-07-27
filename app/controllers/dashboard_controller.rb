class DashboardController < ApplicationController

  def index
    @dashboard = Dashboard.new(current_user)
  end

end
