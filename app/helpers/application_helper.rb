module ApplicationHelper
  def current_week_number
    Date.parse(Time.now.utc.to_s).cweek
  end

  def next_week_number
    current_week_number + 1
  end

  def days_from_today(date)
    distance_of_time_in_words(Time.now, date)
  end

  def unix_to_days_from_today(unix_time)
    date = Time.at(unix_time)
    days_from_today(date)
  end
end
