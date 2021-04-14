require "../spec_helper"

describe Scryfall::Search do
  describe "#search_string" do
    it "creates a scryfall query string" do
      data = {
        card_name:         "Fire",
        card_text:         "draw",
        card_types:        ["instant"],
        card_type_partial: false,
        card_colors:       [Mtg::Card::Color::Red],
        card_color_opp:    "=",
        commander_colors:  [Mtg::Card::Color::Red],
      }

      q = Scryfall::Search.search_string(data)
      q.should eq "fire o:\"draw\" t:instant c=r commander:r"
      results = Scryfall::Api.query(q)
      results.total_cards.should eq 1
      results.data.first.id.should eq UUID.new("4c2029e5-cf7d-461f-b7b9-bf96399d8f49")
    end

    it "translates types correctly" do
      data = {
        card_name:         "",
        card_text:         "",
        card_types:        ["merfolk", "legend"],
        card_type_partial: false,
        card_colors:       Array(Mtg::Card::Color).new,
        card_color_opp:    "=",
        commander_colors:  Array(Mtg::Card::Color).new,
      }

      Scryfall::Search.search_string(data).should eq "t:merfolk t:legend"

      data = {
        card_name:         "",
        card_text:         "",
        card_types:        ["merfolk", "legend"],
        card_type_partial: true,
        card_colors:       Array(Mtg::Card::Color).new,
        card_color_opp:    "=",
        commander_colors:  Array(Mtg::Card::Color).new,
      }

      Scryfall::Search.search_string(data).should eq "(t:merfolk or t:legend)"
    end

    it "translates colors correctly" do
      data = {
        card_name:         "",
        card_text:         "",
        card_types:        Array(String).new,
        card_type_partial: false,
        card_colors:       [Mtg::Card::Color::Red, Mtg::Card::Color::Green],
        card_color_opp:    "=",
        commander_colors:  Array(Mtg::Card::Color).new,
      }

      Scryfall::Search.search_string(data).should eq "c=rg"

      data = {
        card_name:         "",
        card_text:         "",
        card_types:        Array(String).new,
        card_type_partial: false,
        card_colors:       [Mtg::Card::Color::Red, Mtg::Card::Color::Green],
        card_color_opp:    ">=",
        commander_colors:  Array(Mtg::Card::Color).new,
      }

      Scryfall::Search.search_string(data).should eq "c>=rg"

      data = {
        card_name:         "",
        card_text:         "",
        card_types:        Array(String).new,
        card_type_partial: false,
        card_colors:       [Mtg::Card::Color::Red, Mtg::Card::Color::Green],
        card_color_opp:    "<=",
        commander_colors:  Array(Mtg::Card::Color).new,
      }

      Scryfall::Search.search_string(data).should eq "c<=rg"
    end

    it "translates commander colors correctly" do
      data = {
        card_name:         "",
        card_text:         "",
        card_types:        Array(String).new,
        card_type_partial: false,
        card_colors:       Array(Mtg::Card::Color).new,
        card_color_opp:    "=",
        commander_colors:  [Mtg::Card::Color::Black, Mtg::Card::Color::Blue],
      }

      Scryfall::Search.search_string(data).should eq "commander:bu"
    end
  end
end
