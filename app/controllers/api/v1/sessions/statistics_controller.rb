class Api::V1::Sessions::StatisticsController < ApplicationController

  def index
    statistics = Session.data_for_charts(current_user, params[:period])
    render json: statistics
  end

end
