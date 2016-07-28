require 'rails_helper'

describe QuizletService do

  before(:each) do
    user = User.create(gh_uid: 1, name: "Kerry Sheldon", nickname: "kjs222", gh_token: ENV['GITHUB_TOKEN'], email: "myemail@email.com", quiz_id: "kjs222", quiz_token: ENV['QUIZLET_TOKEN'])
    @service = QuizletService.new(user)
  end

  context 'quizsets' do
    it "returns a list of quizets for the current user" do
      VCR.use_cassette("my_sets") do
        sets = @service.get_sets
        expect(sets.count).to eq(12)
        expect(sets.first["title"]).to eq("oauth technical")
      end
    end
  end

  context 'terms' do
    it "returns a list of terms for a given set" do
      VCR.use_cassette("terms") do
        terms = @service.get_terms(145163778)
        expect(terms.count).to eq(9)
        expect(terms.first["term"]).to eq("first oauth technical step")
      end
    end
  end

end
