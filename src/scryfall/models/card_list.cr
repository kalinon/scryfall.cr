require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"
require "./card"

module Scryfall
  struct CardList
    include JSON::Serializable
    include Enumerable(Scryfall::Card)

    @[JSON::Field(ignore: true)]
    @params : HTTP::Params? = nil

    setter uri : URI? = nil
    getter data : Array(Card) = Array(Card).new
    getter has_more : Bool = false
    getter next_page : URI? = nil
    getter total_cards : Int32 = 0
    getter warnings : Array(JSON::Any) = Array(JSON::Any).new

    def initialize; end

    def each
      data.each do |card|
        yield card
      end
    end

    def has_more? : Bool
      self.has_more
    end

    def uri
      @uri ||= parse_uri
    end

    def params
      @params ||= HTTP::Params.parse(uri.query || "")
    end

    def prev_page : URI | Nil
      if page > 1
        new_params = HTTP::Params.parse(params.to_s)
        new_params["page"] = (page - 1).to_s
        prev_uri = URI.parse(uri.to_s)
        prev_uri.query = new_params.to_s
        prev_uri
      else
        nil
      end
    end

    # Returns the current page number
    def page : Int32
      # puts params.inspect
      if params.has_key?("page")
        params["page"].to_i32
      else
        1
      end
    end

    # if no URI was set, try to create one with the next_page information
    private def parse_uri : URI
      nex = next_page
      if nex.nil?
        URI.new
      else
        uri = URI.parse next_page.to_s
        params = HTTP::Params.parse(nex.query || "")
        params["page"] = ((params["page"].to_i32) - 1).to_s
        uri.query = params.to_s
        uri
      end
    end

    # Will make an api request using the next_page value if available
    def fetch_next_page : CardList
      # puts "fetch_next_page : #{next_page.to_s}"
      nex = next_page
      if has_more? && !nex.nil?
        cards = CardList.from_json(Scryfall::Api._request(nex))
        cards.uri = nex
        cards
      else
        CardList.new
      end
    end

    # Will make an api request decrementing the page number if available
    def fetch_prev_page : CardList
      # puts "fetch_prev_page"
      prev = prev_page
      if !prev.nil?
        cards = CardList.from_json(Scryfall::Api._request(prev))
        cards.uri = prev
        cards
      else
        CardList.new
      end
    end
  end
end
