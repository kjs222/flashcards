require 'rails_helper'

RSpec.describe "Sessions CLI API", type: :request do

  it "creates a session when user and skill match" do
    user = create(:user)
    skill = create(:skill, user: user)
    expect(user.sessions.count).to eq(0)

    post "/api/v1/sessions/cli?session[user_id]=#{user.id}&session[skill_name]=#{skill.nickname}"


    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(user.sessions.count).to eq(1)
    expect(user.sessions.first.skill_id).to eq(skill.id)
    expect(json).to eq({"response" => "Session started"})

  end

  it "returns error response when user and skill do not match" do
    user, other_user = create_list(:user, 2)
    skill = create(:skill, user: other_user)

    post "/api/v1/sessions/cli?session[user_id]=#{user.id}&session[skill_name]=#{skill.nickname}"


    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(user.sessions.count).to eq(0)
    expect(other_user.sessions.count).to eq(0)
    expect(json).to eq({"response" => "Skill not found"})

  end

  it "updates a session when there's a recent session for user for that skill" do
    user = create(:user)
    skill = create(:skill, user: user)
    not_recent_session = skill.sessions.create(duration: 30, created_at: 90.minutes.ago)
    recent_session = skill.sessions.create(duration: 30, created_at: 40.minutes.ago)

    patch "/api/v1/sessions/cli?session[user_id]=#{user.id}&session[skill_name]=#{skill.nickname}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to eq({"response" => "Session ended. Total practice time: 40 minutes"})

  end

  it "returns error response when no recent sessions opened" do
    user = create(:user)
    skill = create(:skill, user: user)
    not_recent_session = skill.sessions.create(duration: 30, created_at: 90.minutes.ago)

    patch "/api/v1/sessions/cli?session[user_id]=#{user.id}&session[skill_name]=#{skill.nickname}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to eq({"response" => "Session not found"})

  end

  it "returns error response when request is for skill not associated with user" do
    user = create(:user)
    skill = create(:skill, user: user)
    session = skill.sessions.create(duration: 30, created_at: 40.minutes.ago)

    patch "/api/v1/sessions/cli?session[user_id]=#{user.id}&session[skill_name]=NOT#{skill.nickname}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to eq({"response" => "Session not found"})

  end

end
