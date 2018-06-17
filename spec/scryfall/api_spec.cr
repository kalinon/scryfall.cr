require "../spec_helper"

describe Scryfall::API do
  api = Scryfall::API.new

  it "should fetch cards" do
    body = api.fetch_card_by_name("ponder")
    body.should_not be_nil
  end
end
