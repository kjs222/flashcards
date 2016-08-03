require 'rails_helper'

RSpec.describe Goal, type: :model do

  it "finds username" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    expect(goal.username).to eq(user.name)
  end

  it "calculates available points" do
    create_list(:current_goal, 2)
    create(:next_week_goal)
    expect(Goal.available_points).to eq(15)
  end

end
