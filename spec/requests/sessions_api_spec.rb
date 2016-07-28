require 'rails_helper'

RSpec.describe "Sessions API", :type => :request do

  it 'creates a session and returns data on session and associated skill' do

    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    expect(user.sessions.count).to eq(0)

    post "/api/v1/sessions?session[skill_id]=#{skill.id}&session[duration]=30"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json.first["skill_id"]).to eq(skill.id)
    expect(json.last["nickname"]).to eq(skill.nickname)
    expect(json.first["duration"]).to eq(30)
    expect(user.sessions.count).to eq(1)
  end

end
