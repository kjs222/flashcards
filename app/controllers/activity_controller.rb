class ActivityController <ApplicationController

  def index
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
  end

end
