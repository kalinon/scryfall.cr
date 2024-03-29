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
    define_api_method :get, "/catalog/:catalog", Scryfall::Catalog, :catalog

    macro define_catalogs
      {% for cat in %w(card-names
                      artist-names
                      word-bank
                      creature-types
                      planeswalker-types
                      land-types
                      artifact-types
                      enchantment-types
                      spell-types
                      powers
                      toughnesses
                      loyalties
                      watermarks
                      keyword-abilities
                      keyword-actions
                      ability-words) %}
      define_api_method :get, "/catalog/{{ cat.id }}", Scryfall::Catalog, :get_{{ cat.gsub(/\-/, "_").id }}
      {% end %}
    end

    define_catalogs

    # Look up cards on query
    def self.query(q : String, params = Hash(String, String).new) : CardList
      params = HTTP::Params.build do |form|
        form.add "order", "set" unless params.has_key?("order")
        form.add "unique", "prints" unless params.has_key?("unique")
        form.add "q", q
        params.each do |k, v|
          form.add k.to_s, v.to_s
        end
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
