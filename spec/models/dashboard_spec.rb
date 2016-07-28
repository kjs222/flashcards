require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  it "initializes with all info when all exist" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    next_goal = create(:next_week_goal, skill: skill)
    session = create(:session, skill: skill)

    dash = Dashboard.new(user)
    expect(dash.skills.count).to eq(1)
    expect(dash.current_goals.count).to eq(1)
    expect(dash.next_goals.count).to eq(1)
    expect(dash.sessions.count).to eq(1)
  end

  it "initializes with some info missing" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    session = create(:session, skill: skill)

    dash = Dashboard.new(user)
    expect(dash.skills.count).to eq(1)
    expect(dash.current_goals.count).to eq(1)
    expect(dash.next_goals.count).to eq(0)
    expect(dash.sessions.count).to eq(1)
  end

end
