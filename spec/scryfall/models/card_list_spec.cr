require "../../spec_helper"

describe Scryfall::CardList do
  cards = Scryfall::Api.fetch_card_by_name("light")

  it "should have cards" do
    cards.should be_a Scryfall::CardList
    cards.data.empty?.should be_false
  end

  describe "#total_cards" do
    it "size is 175" do
      cards.size.should eq 175
    end
  end

  describe "#page" do
    it "page is 1" do
      cards.page.should eq 1
    end
  end

  describe "#has_more?" do
    it "has more cards" do
      cards.has_more?.should be_truthy
    end
  end

  describe "#params" do
    it "should have params" do
      cards.params.should_not be_nil
    end
  end

  describe "#fetch_next_page" do
    next_page = cards.fetch_next_page

    it "should fetch next page" do
      next_page.should_not be_nil
    end
    it "size is 175" do
      next_page.size.should eq 175
    end
    it "page is 2" do
      next_page.page.should eq 2
    end
  end

  describe "#fetch_prev_page" do
    prev_page = cards.fetch_next_page.fetch_prev_page

    it "should fetch next page" do
      prev_page.should_not be_nil
    end
    it "size is 175" do
      prev_page.size.should eq 175
    end
    it "page is 1" do
      prev_page.page.should eq 1
    end
  end
end
