require 'rails_helper'

RSpec.describe "Goals API", :type => :request do

  it 'creates a goals and returns data on goal and associated skill' do

    user = create(:user)
    skill = create(:skill, user: user)
    expect(user.goals.count).to eq(0)


    post "/api/v1/goals?goal[skill_id]=#{skill.id}&goal[num_sessions]=3&goal[session_length]=30&goal[week_number]=#{Date.today.cweek}"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json.first["skill_id"]).to eq(skill.id)
    expect(json.first["num_sessions"]).to eq(3)
    expect(user.goals.count).to eq(1)
  end

end
