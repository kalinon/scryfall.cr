require "toshi"
require "uuid"
require "./models/*"

module Scryfall
  module Api
    include Toshi::Api

    SF_SEARCH_PATH = "/cards/search"

    define_api "api.scryfall.com", default_headers: HTTP::Headers{
      "Content-Type" => "application/json; charset=utf-8",
    }

    define_api_method :get, "/bulk-data", BulkDataList, :bulk_data
    define_api_method :get, "/sets", SetList, :sets

    # Look up card in scryfall by id
    def self.fetch_card(id : UUID) : Scryfall::Card
      fetch_card(id.to_s)
    end

    # Look up card in scryfall by id
    define_api_method :get, "/cards/:id", Scryfall::Card, :fetch_card

    # Look up card in scryfall by set
    define_api_method :get, "/cards/:set/:num", Scryfall::Card, :fetch_card_by_set

    # Look up card in scryfall by multiverse id
    define_api_method :get, "/cards/multiverse/:id", Scryfall::Card, :fetch_card_by_mv

    # https://scryfall.com/docs/api/catalogs
    define_api_method :get, "/catalog/:catalog", Scryfall::Catalog

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
      card_list = Scryfall::CardList.from_json(_request(uri))
      card_list.uri = uri
      card_list
    end
  end
end
