require 'rails_helper'

RSpec.describe "Skills API", :type => :request do

  it 'creates a skill and returns data on skill' do

    user = create(:user)
    expect(user.skills.count).to eq(0)

    post "/api/v1/skills?skill[user_id]=#{user.id}&skill[nickname]=skill1&skill[description]=description for skill 1"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json["nickname"]).to eq("skill1")
    expect(json["description"]).to eq("description for skill 1")
    expect(user.skills.count).to eq(1)
  end

end
