require "test_helper"

describe Skill do
  let(:skill) { Skill.new }

  it "must be valid" do
    value(skill).must_be :valid?
  end
end
