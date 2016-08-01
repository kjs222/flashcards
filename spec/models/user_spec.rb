require 'rails_helper'

RSpec.describe User, type: :model do

  it "identifies current goals for current user only" do
    user, other_user = create_list(:user, 2)
    user_skill = create(:skill, user: user)
    other_user_skill = create(:skill, user: other_user)
    user_goal = create(:current_goal, skill: user_skill)
    other_user_goal = create(:current_goal, skill: other_user_skill)

    expect(user.current_goals.count).to eq(1)
    expect(user.current_goals.first.skill).to eq(user_skill)

  end

  it "identifies current goals but not past or future" do
    user = create(:user)
    skill = create(:skill, user: user)
    current_goal = create(:current_goal, skill: skill)
    past_goal = create(:past_goal, skill: skill)
    future_goal = create(:next_week_goal, skill: skill)

    expect(user.current_goals.count).to eq(1)
    expect(user.current_goals.first.week_number).to eq(Date.parse(Time.now.utc.to_s).cweek)

  end

  it "identifies next week goals but not past or current" do
    user = create(:user)
    skill = create(:skill, user: user)
    current_goal = create(:current_goal, skill: skill)
    past_goal = create(:past_goal, skill: skill)
    future_goal = create(:next_week_goal, skill: skill)

    expect(user.next_week_goals.count).to eq(1)
    expect(user.next_week_goals.first.week_number).to eq(Date.parse(Time.now.utc.to_s).cweek + 1)
  end

  it "generates skill option lists" do
    user = create(:user)
    skill1 = create(:skill, user: user)
    skill2 = create(:skill, user: user)
    expect(user.skill_form_options.count).to eq(2)
    expect(user.skill_form_options.first).to eq([skill1.nickname, skill1.id])
  end

  it "generates session option lists" do
    user = create(:user)
    skill = create(:skill, user: user)
    current_goal = create(:current_goal, skill: skill)
    expect(user.session_form_options.count).to eq(1)
    expect(user.session_form_options.first).to eq([skill.nickname, skill.id])
  end

  it "adds quizlet credentials" do
    user = create(:user)
    user.add_quizlet_credentials({"uid" => "x", "credentials" => {"token" => "x-token"}})
    expect(user.quiz_id).to eq("x")
    expect(user.quiz_token).to eq("x-token")
  end

  it "gets quiz credentials for cli user" do
    user = create(:user)
    user.add_quizlet_credentials({"quiz_id" => "x", "credentials" => {"token" => "x-token"}})
    cred = User.get_credentials_for_cli("nickname", "password")
    expect(cred).to eq({"id" => user.id, "quiz_id" => user.quiz_id, "quiz_token" => user.quiz_token})
  end

  it "gets user not found as quiz credentials for bad user info" do
    user = create(:user)
    user.add_quizlet_credentials({"quiz_id" => "x", "credentials" => {"token" => "x-token"}})
    cred = User.get_credentials_for_cli("nickname", "not_password")
    expect(cred).to eq({"id"=>"User not found", "quiz_id"=>"User not found", "quiz_token"=>"User not found"})
  end

  it "calculates total points for user" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    session = create(:session, skill: skill)
    expect(user.points).to eq(3)
  end

  it "calculates total points for user" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    session1 = create(:session, skill: skill)
    session2 = create(:session_2_weeks_ago, skill: skill)
    expect(user.points).to eq(5)
  end

  it "calculates current week points for user" do
    user = create(:user)
    skill = create(:skill, user: user)
    goal = create(:current_goal, skill: skill)
    session_current = skill.sessions.create(duration: 60)
    session_past = create(:session_2_weeks_ago, skill: skill)
    expect(user.current_week_points).to eq(10)
  end





end
