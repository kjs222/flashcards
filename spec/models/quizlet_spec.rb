require 'rails_helper'

RSpec.describe Quizlet do

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

  context '.search_sets by term' do
    it "returns a list of quizsets based on search term" do
      search_term = "SQL"
      VCR.use_cassette("search-#{search_term}") do
        results = Quizlet.search_results(@user, search_term, "")
        expect(results.first).to be_an_instance_of(Quizlet)
        expect(results.first).to respond_to(:title)
        expect(results.first).to respond_to(:created_date)
        expect(results.first).to respond_to(:term_count)
        expect(results.first.title).to eq("SQL")
        expect(results.first.created_by).to eq("kjs222")
      end
    end
  end

  context '.search_sets by user' do
    it "returns a list of quizsets based on user" do
      created_by_search = "kjs222"
      VCR.use_cassette("search-#{created_by_search}") do
        results = Quizlet.search_results(@user, "", "#{created_by_search}")
        expect(results.first).to be_an_instance_of(Quizlet)
        expect(results.first).to respond_to(:title)
        expect(results.first).to respond_to(:created_date)
        expect(results.first).to respond_to(:term_count)
        expect(results.first.title).to eq("Methods Description")
        expect(results.first.created_by).to eq("kjs222")
      end
    end
  end

  context '.search_sets by user and term' do
    it "returns a list of quizsets based on user" do
      created_by_search = "kjs222"
      search_term = "SQL"
      VCR.use_cassette("search-#{search_term}-#{created_by_search}") do
        results = Quizlet.search_results(@user, "#{search_term}", "#{created_by_search}")
        expect(results.first).to be_an_instance_of(Quizlet)
        expect(results.first).to respond_to(:title)
        expect(results.first).to respond_to(:created_date)
        expect(results.first).to respond_to(:term_count)
        expect(results.first.title).to eq("SQL")
        expect(results.first.created_by).to eq("kjs222")
      end
    end
  end


end
