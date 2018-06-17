require "../spec_helper"

describe Scryfall::API do
  api = Scryfall::API.new

  describe "#fetch_card_by_name" do
    it "should fetch cards" do
      body = api.fetch_card_by_name("ponder")
      body.should_not be_nil
    end
  end

  describe "#fetch_card" do
    it "should fetch by UUID" do
      body = api.fetch_card(UUID.new("af8b9c79-a161-4d7d-944d-82a44a5f2ab9"))
      body.should_not be_nil
    end
  end
end
