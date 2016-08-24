class ActivityController <ApplicationController

  def index
    @all_activities = PublicActivity::Activity.order('created_at DESC').limit(20)
    @follower_activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.users_following.map {|u| u.id}).limit(20)

  end

end
