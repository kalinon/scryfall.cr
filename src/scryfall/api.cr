require "halite"
require "uuid"
require "./models/*"
require "spoved/logger"
require "./search"

module Scryfall
  class Api
    class Error < Exception; end

    extend Scryfall::Search

    SF_SCHEME      = "https"
    SF_HOST        = "api.scryfall.com"
    SF_SEARCH_PATH = "/cards/search"
    SF_HEADERS     = {
      "Content-Type" => "application/json; charset=utf-8",
    }
    SF_SLEEP_TIME = 0.5

    spoved_logger

    # Fetch set list
    def self.sets : SetList
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

    # Look up card in scryfall by set
    def self.fetch_card_by_set(set_code : String, set_num : String | Int32) : Scryfall::Card
      uri = "/cards/#{set_code}/#{set_num}"
      Scryfall::Card.from_json(make_request(uri))
    end

    # Look up card in scryfall by multiverse id
    def self.fetch_card_by_mv(id : Int32) : Scryfall::Card
      Scryfall::Card.from_json(make_request("/cards/multiverse/#{id}"))
    end

    # https://scryfall.com/docs/api/catalogs
    def self.catalog(catalog : String) : Scryfall::Catalog
      Scryfall::Catalog.from_json(make_request("/catalog/#{catalog}"))
    end

    # Look up cards on query
    def self.query(q : String) : CardList
      params = HTTP::Params.build do |form|
        form.add "order", "set"
        form.add "unique", "prints"
        form.add "q", q
      end

      fetch_card_list(SF_SEARCH_PATH, params)
    end

    # Look up card in scryfall by name
    def self.search_card_by_name(name : String, set_code : String? = nil) : CardList
      q = "name:!\"#{name}\""
      q += " e:\"#{set_code}\"" unless set_code.nil?

      self.query(q)
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
      logger.debug { "GET: #{uri.to_s}" }
      Halite.get(uri.to_s, headers: SF_HEADERS).body
    end
  end
end
