require 'rails_helper'

describe QuizletTerm do

  before(:each) do
    @user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
  end

  context '.terms' do
    it "returns a list of terms" do
      VCR.use_cassette("terms") do
        terms = QuizletTerm.terms(@user, 145163778)
        expect(terms.first).to be_an_instance_of(QuizletTerm)
        expect(terms.first).to respond_to(:term)
        expect(terms.first).to respond_to(:definition)
      end
    end
  end

end
