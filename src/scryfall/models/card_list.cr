require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"
require "./card"

module Scryfall
  struct CardList
    JSON.mapping(
      total_cards: {type: Int32, default: 0},
      has_more: {type: Bool, default: false},
      next_page: {type: URI, nilable: true},
      data: {type: Array(Card), default: [] of Card},
      warnings: {type: Array(JSON::Any), default: [] of JSON::Any}
    )
  end
end
