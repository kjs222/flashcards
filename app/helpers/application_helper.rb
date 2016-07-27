module ApplicationHelper
  def current_week_number
    Date.today.cweek
  end

  def next_week_number
    Date.today.cweek + 1
  end

  def days_from_today(date)
    distance_of_time_in_words(Time.now, date)
  end
end
