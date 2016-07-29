require 'rails_helper'

RSpec.describe "Sessions Statistics API", :type => :request do

  it 'returns last weeks data for charting' do
    user = create(:user)
    skill = create(:skill, user: user)
    past_goal1, past_goal2 = create_list(:past_goal, 2)

    get 'api/v1/sessions/statistics?period=1'

    expect(response).to be_success
    # expect(respone).to TBD depending on charting library




  end
end
