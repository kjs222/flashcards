module ApplicationHelper
  def current_week_number
    Date.today.cweek
  end

  def next_week_number
    Date.today.cweek + 1
  end
end
