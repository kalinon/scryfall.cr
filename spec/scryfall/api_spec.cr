require "../spec_helper"

describe Scryfall::Api do
  describe "#fetch_card_by_name" do
    it "should fetch cards" do
      list = Scryfall::Api.search_card_by_name("ponder")
      list.should_not be_nil
      list.should be_a Scryfall::CardList
    end
  end

  describe "#fetch_card" do
    it "should fetch by UUID" do
      card = Scryfall::Api.fetch_card(UUID.new("af8b9c79-a161-4d7d-944d-82a44a5f2ab9"))
      card.should_not be_nil
      card.should be_a Scryfall::Card
    end
  end
end
