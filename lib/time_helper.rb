module TimeHelper

  def current_week
    Date.parse(Time.now.utc.to_s).cweek
  end

  def last_week
    current_week - 1
  end

  def next_week
    current_week + 1
  end

end
