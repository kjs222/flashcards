require 'rails_helper'

RSpec.describe "User Find API", :type => :request do

  it 'finds a user by nickname' do

    user = create(:user)

    get "/api/v1/users/find?user_nickname=#{user.nickname}"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json["name"]).to eq(user.name)
    expect(json["id"]).to eq(user.id)

  end

  it 'finds does not find a users that doesnt exist' do

    get "/api/v1/users/find?user_nickname=notauser"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json["message"]).to eq("User not found")

  end


end
