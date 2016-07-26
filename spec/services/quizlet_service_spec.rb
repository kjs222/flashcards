# require 'rails_helper'
#
# describe QuizletService do
#
#   before(:each) do
#     user = User.create(uid: 'kjs222', token: ENV['QUIZLET_TOKEN'])
#     @service = QuizletService.new(user)
#   end
#
#   context '#activity' do
#     it "returns a list of activity for the current user" do
#       VCR.use_cassette("my_sets") do
#         sets = @service.get_sets
#         expect(sets.count).to eq(12)
#         expect(sets.first["title"]).to eq("oauth technical")
#       end
#     end
#   end
#
# end
