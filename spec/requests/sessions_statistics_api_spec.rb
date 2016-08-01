require 'rails_helper'

RSpec.describe "Sessions Statistics API", :type => :request do

  it 'returns last weeks data for charting' do
    user = create(:user)
    skill = create(:skill, user: user)
    past_goal1, past_goal2 = create_list(:past_goal, 2)
    session_date = 5.days.ago
    session = skill.sessions.create(duration: 60, created_at: 5.days.ago)

    get '/api/v1/sessions/statistics?period=1'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.first.count).to eq(8)
    expect(json.first.include?(session_date.strftime('%b %d'))).to eq(true)

    expect(json.last.count(0)).to eq(7)
    expect(json.last.count(60)).to eq(1)
  end

  it 'returns last months data for charting' do
    user = create(:user)
    skill = create(:skill, user: user)
    past_goal1, past_goal2 = create_list(:past_goal, 2)
    session_date = 5.days.ago
    session = skill.sessions.create(duration: 60, created_at: 5.days.ago)

    get '/api/v1/sessions/statistics?period=4'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.first.count).to eq(29)
    expect(json.first.include?(session_date.strftime('%b %d'))).to eq(true)

    expect(json.last.count(0)).to eq(28)
    expect(json.last.count(60)).to eq(1)
  end

  it 'returns last years data for charting' do
    user = create(:user)
    skill = create(:skill, user: user)
    past_goal1, past_goal2 = create_list(:past_goal, 2)
    session_date = 5.days.ago
    session = skill.sessions.create(duration: 60, created_at: 5.days.ago)

    get '/api/v1/sessions/statistics?period=52'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.first.count).to eq(13)
    expect(json.first.include?(session_date.strftime('%B %Y'))).to eq(true)

    expect(json.last.count(0)).to eq(12)
    expect(json.last.count(60)).to eq(1)
  end
end
