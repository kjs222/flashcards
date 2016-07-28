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
