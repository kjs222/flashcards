require 'rails_helper'

RSpec.describe Session, type: :model do
  #not used anymore
  xit "identifies correct sessions for a time period" do
    session_1_week_ago = create(:session_1_week_ago)
    session_2_weeks_ago = create(:session_2_weeks_ago)
    session_3_weeks_ago = create(:session_3_weeks_ago)
    session_4_weeks_ago = create(:session_4_weeks_ago)
    session_2_months_ago = create(:session_2_months_ago)

    expect(Session.sessions_for_charts(1).count).to eq(1)
    expect(Session.sessions_for_charts(1).first).to eq(session_1_week_ago)

    expect(Session.sessions_for_charts(2).count).to eq(2)
    expect(Session.sessions_for_charts(2).last).to eq(session_2_weeks_ago)

    expect(Session.sessions_for_charts(8).count).to eq(5)
    expect(Session.sessions_for_charts(8).last).to eq(session_2_months_ago)

  end

  it "gets session duration sum by day" do
    user = create(:user)
    skill = create(:skill, user: user)
    session1 = skill.sessions.create(duration: 60, created_at: "2016-08-01 00:00:00")
    session2 = skill.sessions.create(duration: 60, created_at: "2016-08-02 00:00:00")
    total_duration = session1.duration + session2.duration

    expect(Session.time_series_session_data(user, session1.created_at, session1.created_at + 2.days, "day")).to eq([["Aug 01", "Aug 02", "Aug 03"], [session1.duration, session2.duration, 0]])
  end

  it "gets session duration sum by month" do
    user = create(:user)
    skill = create(:skill, user: user)
    session1 = skill.sessions.create(duration: 60, created_at: "2016-08-01 00:00:00")
    session2 = skill.sessions.create(duration: 60, created_at: "2016-08-01 00:00:00")
    total_duration = session1.duration + session2.duration

    expect(Session.time_series_session_data(user, session1.created_at, session1.created_at + 1.days, "month")).to eq([["August 2016"], [total_duration]])
  end

  it "gets correct data in right format based on time period" do
    user = create(:user)
    skill = create(:skill, user: user)
    session_1_week_ago = create(:session_1_week_ago, skill: skill)
    session_2_weeks_ago = create(:session_2_weeks_ago, skill: skill)
    session_4_weeks_ago = create(:session_4_weeks_ago, skill: skill)
    session_2_months_ago = create(:session_2_months_ago, skill: skill)

    expect(Session.data_for_charts(user, 2).count).to eq(2)
    expect(Session.data_for_charts(user, 1).first.first.include?("2016")).to be(false)
    expect(Session.data_for_charts(user, 52).first.first.include?("2015")).to be(true)
    expect(Session.data_for_charts(user, 52).last.count).to eq(13)


  end

  it "returns a username for a sessions user" do
    user = create(:user)
    skill = create(:skill, user: user)
    session = create(:session, skill: skill)

    expect(session.username).to eq(user.name)
  end

  it "calculates duration for a practice session " do
    skill = create(:skill)
    session = Session.create(skill_id: skill.id, created_at: 10.minutes.ago)
    expect(session.calculate_duration).to eq(10)
  end

  it "finds most recent session for  a given skill" do
    skill, other_skill = create_list(:skill, 2)
    most_recent = create(:session, skill: skill)
    not_most_recent = create(:session_1_week_ago, skill: skill)
    other_skill_session = create(:session, skill: other_skill)
    expect(Session.find_recent_by_skill(skill)).to eq(most_recent)
  end

end
