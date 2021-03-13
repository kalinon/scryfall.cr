require "halite"
require "uuid"
require "./models/*"
require "spoved/logger"

module Scryfall
  class Api
    class Error < Exception
    end

    SF_SCHEME      = "https"
    SF_HOST        = "api.scryfall.com"
    SF_SEARCH_PATH = "/cards/search"
    SF_HEADERS     = {
      "Content-Type" => "application/json; charset=utf-8",
    }
    SF_SLEEP_TIME = 0.5

    spoved_logger

    # Fetch set list
    def self.set : SetList
      Scryfall::SetList.from_json(make_request("/sets"))
    end

    # Look up card in scryfall by id
    def self.fetch_card(id : UUID) : Scryfall::Card
      fetch_card(id.to_s)
    end

    # Look up card in scryfall by id
    def self.fetch_card(id : String) : Scryfall::Card
      Scryfall::Card.from_json(make_request("/cards/#{id}"))
    end

    # Look up card in scryfall by multiverse id
    def self.fetch_card_by_mv(id : Int32) : Scryfall::Card
      Scryfall::Card.from_json(make_request("/cards/multiverse/#{id}"))
    end


    # Look up cards on query
    def self.fetch_card_by_name(query : String) : CardList
      params = HTTP::Params.build do |form|
        form.add "order", "set"
        form.add "unique", "prints"
        form.add "q", query
      end

      fetch_card_list(SF_SEARCH_PATH, params)
    end

    # Look up card in scryfall by name
    def self.fetch_card_by_name(name : String) : CardList
      params = HTTP::Params.build do |form|
        form.add "order", "set"
        form.add "unique", "prints"
        form.add "q", "name:!\"#{name}\""
      end

      fetch_card_list(SF_SEARCH_PATH, params)
    end

    # Function to wrap card list searches to properly set the request URI
    protected def self.fetch_card_list(path : String, params : String | Nil = nil) : CardList
      uri = make_request_uri(path, params)
      card_list = Scryfall::CardList.from_json(make_request(uri))
      card_list.uri = uri
      card_list
    end

    # URI helper function
    def self.make_request_uri(path : String, params : String | Nil = nil) : URI
      URI.new(scheme: SF_SCHEME, host: SF_HOST, path: path, query: params.to_s)
    end

    # Make a request with a string URI
    def self.make_request(path : String, params : String | Nil = nil)
      make_request(make_request_uri(path, params))
    end

    # Make a request with a URI object
    def self.make_request(uri : URI)
      sleep(SF_SLEEP_TIME)
      logger.info { "GET: #{uri.to_s}" }
      Halite.get(uri.to_s, headers: SF_HEADERS).body
    end
  end
end
