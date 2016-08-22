require 'rails_helper'

RSpec.describe "User Follower API", :type => :request do

  it 'creates a user follower and returns data on follower and associated user' do

    followed, follower = create_list(:user, 2)
    expect(followed.followers.count).to eq(0)
    expect(follower.users_following.count).to eq(0)


    post "/api/v1/user_followers?user_follower[user_id]=#{followed.id}&user_follower[follower_id]=#{follower.id}"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json.first["user_id"]).to eq(followed.id)
    expect(json.first["follower_id"]).to eq(follower.id)
    expect(json.last["name"]).to eq(follower.name)

    expect(followed.followers.count).to eq(1)
    expect(followed.followers.first.name).to eq(follower.name)

    expect(follower.users_following.first.name).to eq(followed.name)
  end

  it 'deletes a user follower' do

    followed, follower = create_list(:user, 2)
    uf = followed.user_followers.create(follower_id: follower.id)
    expect(followed.followers.count).to eq(1)
    expect(follower.users_following.count).to eq(1)

    delete "/api/v1/user_followers/#{uf.id}"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json.first).to eq(["message", "deleted"])

    expect(followed.followers.count).to eq(0)
    expect(follower.users_following.count).to eq(0)

  end

end
