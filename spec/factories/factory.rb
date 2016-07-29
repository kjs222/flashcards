FactoryGirl.define do

  factory :user do
    gh_uid "1"
    gh_token "1"
    name { generate :user_name }
    nickname "nickname"
    password "password"
  end

  sequence :user_name do |n|
    "user-#{n}"
  end

  factory :skill do
    user
    nickname { generate :skill_nickname }
    description "skill description"
  end

  sequence :skill_nickname do |n|
    "skill-#{n}"
  end

  factory :session do
    skill
    duration 15
  end

  factory :session_fixed_date, class: Session do
    skill
    duration 15
    created_at "2016-01-01 00:00:00"
  end

  factory :session_1_week_ago, class: Session do
    skill
    duration 10
    created_at 6.days.ago
  end

  factory :session_2_weeks_ago, class: Session do
    skill
    duration 10
    created_at 13.days.ago
  end

  factory :session_3_weeks_ago, class: Session do
    skill
    duration 10
    created_at 20.days.ago
  end

  factory :session_4_weeks_ago, class: Session do
    skill
    duration 10
    created_at 27.days.ago
  end

  factory :session_2_months_ago, class: Session do
    skill
    duration 10
    created_at 55.days.ago
  end


  factory :current_goal, class: Goal do
    num_sessions 2
    session_length 15
    skill
    week_number Date.today.cweek
  end

  factory :next_week_goal, class: Goal do
    num_sessions 2
    session_length 15
    skill
    week_number (Date.today.cweek + 1)
  end

  factory :past_goal, class: Goal do
    num_sessions 2
    session_length 15
    skill
    week_number (Date.today.cweek - 1)
  end


end
