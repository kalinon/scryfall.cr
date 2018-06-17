require "./spec_helper"

describe Scryfall do
  it "should have a version" do
    Scryfall::VERSION.should_not be_nil
  end
end
