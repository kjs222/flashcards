require "test_helper"

describe Goal do
  let(:goal) { Goal.new }

  it "must be valid" do
    value(goal).must_be :valid?
  end
end
