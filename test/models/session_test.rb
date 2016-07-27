require "test_helper"

describe Session do
  let(:session) { Session.new }

  it "must be valid" do
    value(session).must_be :valid?
  end
end
