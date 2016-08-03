require 'rails_helper'

RSpec.describe Skill, type: :model do
  it "identifies username for the skill's user" do
    user = create(:user)
    skill = create(:skill, user: user)
    expect(skill.username).to eq(user.name)
  end

  it "identifies the number of sessions for a skill" do
    skill, other_skill = create_list(:skill, 2)
    5.times do
      create(:session, skill: skill)
      create(:session, skill: other_skill)
    end
    expect(skill.num_sessions).to eq(5)
  end

  it "identifies the total practice minutes for a skill" do
    skill, other_skill = create_list(:skill, 2)
    5.times do
      create(:session, skill: skill)
      create(:session, skill: other_skill)
    end
    expect(skill.total_practice_time).to eq(75)
  end

  it "identifies num of points earned by user" do
    skill, other_skill = create_list(:skill, 2)
    5.times do
      create(:session, skill: skill)
      create(:session, skill: other_skill)
    end
    expect(skill.points_earned).to eq(12)
  end

  it "identifies the most recent practice date for a skill" do
    skill, other_skill = create_list(:skill, 2)
    most_recent = create(:session_1_week_ago, skill: skill)
    not_most_recent = create(:session_2_weeks_ago, skill: skill)
    expect(skill.last_practiced_date).to eq(most_recent.created_at)
  end

end
