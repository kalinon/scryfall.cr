require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"
require "./card"

module Scryfall
  struct CardList
    include Enumerable(Scryfall::Card)
    setter uri : URI?

    def initialize
      @total_cards = 0
      @has_more = false
      @next_page = nil
      @data = [] of Card
      @warnings = [] of JSON::Any
    end

    JSON.mapping(
      total_cards: {type: Int32, default: 0},
      has_more: {type: Bool, default: false},
      next_page: {type: URI, nilable: true},
      data: {type: Array(Card), default: [] of Card},
      warnings: {type: Array(JSON::Any), default: [] of JSON::Any}
    )

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
      if params.has_key?("page")
        params["page"].to_i32
      else
        0
      end
    end

    # if no URI was set, try to create one with the next_page information
    private def parse_uri : URI
      nex = next_page
      unless nex.nil?
        uri = URI.parse next_page.to_s
        params = HTTP::Params.parse(nex.query || "")
        uri.query = params.to_s
        uri
      else
        URI.new
      end
    end

    # Will make an api request using the next_page value if available
    def fetch_next_page : CardList
      nex = next_page
      if has_more? && !nex.nil?
        CardList.from_json Scryfall::Api.make_request(nex)
      else
        CardList.new
      end
    end

    # Will make an api request decrementing the page number if available
    def fetch_prev_page : CardList
      prev = prev_page
      if !prev.nil?
        CardList.from_json Scryfall::Api.make_request(prev)
      else
        CardList.new
      end
    end
  end
end
