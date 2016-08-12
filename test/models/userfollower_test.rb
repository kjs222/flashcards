require "test_helper"

describe Userfollower do
  let(:userfollower) { Userfollower.new }

  it "must be valid" do
    value(userfollower).must_be :valid?
  end
end
