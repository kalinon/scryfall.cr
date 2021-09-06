require "halite"
require "uuid"
require "./models/*"
require "spoved/logger"
require "./search"
require "db/pool"

module Scryfall
  class Api
    class Error < Exception
      class ConnectionLost < ::DB::PoolResourceLost(HTTP::Client); end
    end

    record Options, pool_capacity = 200, initial_pool_size = 20, pool_timeout = 0.1, sleep_time = 0.1

    extend Scryfall::Search

    SF_SCHEME      = "https"
    SF_HOST        = "api.scryfall.com"
    SF_SEARCH_PATH = "/cards/search"
    SF_HEADERS     = HTTP::Headers{
      "Content-Type" => "application/json; charset=utf-8",
    }
    @@sleep_time : Float64 = 0.0
    @@pool : DB::Pool(HTTP::Client) = DB::Pool(HTTP::Client).new do
      HTTP::Client.new(URI.new(scheme: SF_SCHEME, host: SF_HOST))
    end

    def self.configure(options : Options = Options.new, &block)
      yield options
      configure(options)
    end

    def self.configure(options : Options = Options.new)
      @@sleep_time = options.sleep_time
      @@pool = DB::Pool(HTTP::Client).new(max_pool_size: options.pool_capacity, initial_pool_size: options.initial_pool_size, checkout_timeout: options.pool_timeout) do
        HTTP::Client.new(URI.new(scheme: SF_SCHEME, host: SF_HOST))
      end
    end

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
      URI.new(path: path, query: params)
    end

    # Make a request with a string URI
    def self.make_request(path : String, params : String | Nil = nil)
      make_request(make_request_uri(path, params))
    end

    # Make a request with a URI object
    def self.make_request(uri : URI)
      sleep(@@sleep_time) if @@sleep_time > 0
      logger.debug { "GET: #{uri}" }
      using_connection do |client|
        client.get(uri.to_s, headers: SF_HEADERS).body
      end
    end

    private def self.using_connection
      @@pool.retry do
        @@pool.checkout do |conn|
          yield conn
        rescue ex : IO::Error | IO::TimeoutError
          logger.error { ex.message }
          logger.trace(exception: ex) { ex.message }
          raise Error::ConnectionLost.new(conn)
        end
      end
    end
  end
end
