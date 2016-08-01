module TimeHelper

  def current_week
    Date.today.cweek
  end

  def last_week
    Date.today.cweek - 1
  end

  def next_week
    Date.today.cweek + 1
  end

end
