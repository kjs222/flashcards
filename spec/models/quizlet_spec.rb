require 'rails_helper'

describe Quizlet do

  before(:each) do
    @user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
  end

  context '.quizsets' do
    it "returns a list of quizsets" do
      VCR.use_cassette("my_sets") do
        sets = Quizlet.sets(@user)
        expect(sets.first).to be_an_instance_of(Quizlet)
        expect(sets.first).to respond_to(:title)
        expect(sets.first).to respond_to(:created_date)
        expect(sets.first).to respond_to(:term_count)
      end
    end
  end

end
