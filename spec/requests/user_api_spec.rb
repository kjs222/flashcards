require 'rails_helper'

RSpec.describe "User API", :type => :request do

  it 'retrieves user credentials' do

    user = create(:user)
    user.add_quizlet_credentials({"uid" => "x", "credentials" => {"token" => "x-token"}})

    get "/api/v1/authenticate?uid=#{user.nickname}&password=#{user.password}"

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json["uid"]).to eq("x")
    expect(json["token"]).to eq("x-token")
  end

end
