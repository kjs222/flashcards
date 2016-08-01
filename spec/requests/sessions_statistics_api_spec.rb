require 'rails_helper'

RSpec.describe "Sessions Statistics API", :type => :request do

  it 'returns last weeks data for charting' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

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

  it 'returns last weeks data for charting and excludes other user info' do
    user, other_user = create_list(:user, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    skill = create(:skill, user: user)
    other_user_skill = create(:skill, user: other_user)

    session_date = 5.days.ago
    user_session = skill.sessions.create(duration: 60, created_at: session_date)
    other_user_session = other_user_skill.sessions.create(duration: 60, created_at: session_date)

    get '/api/v1/sessions/statistics?period=1'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.first.count).to eq(8)
    expect(json.first.include?(session_date.strftime('%b %d'))).to eq(true)

    expect(json.last.count(0)).to eq(7)
    expect(json.last.count(60)).to eq(1)
    expect(json.last.count(120)).to eq(0)
  end

  it 'returns last months data for charting' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )
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
