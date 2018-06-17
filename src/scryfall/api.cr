require "halite"

module Scryfall
  class API
    class Error < Exception
    end

    SF_SCHEME      = "https"
    SF_HOST        = "api.scryfall.com"
    SF_SEARCH_PATH = "/cards/search"

    # Look up card in scryfall by multiverse id
    def fetch_card_by_mv(id : Int32) : String
      make_request("/cards/multiverse/#{id}")
    end

    # Look up card in scryfall by name
    def fetch_card_by_name(name : String) : String
      params = HTTP::Params.build do |form|
        form.add "order", "set"
        form.add "unique", "prints"
        form.add "q", "name:!\"#{name}\""
      end
      make_request(SF_SEARCH_PATH, params)
    end

    private def make_request(path : String, params : String | Nil = nil)
      sleep(0.5)
      uri = URI.new(scheme: SF_SCHEME, host: SF_HOST, path: path, query: params.to_s)
      Halite.get(uri.to_s).body
    end
  end
end
