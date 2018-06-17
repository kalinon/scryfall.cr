require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"

module Scryfall
  struct CardFace
    JSON.mapping(
      name: String,
      printed_name: {type: String, nilable: true},
      type_line: {type: String, default: ""},
      printed_type_line: {type: String, default: ""},
      oracle_text: {type: String, nilable: true},
      printed_text: String,
      mana_cost: String,
      colors: {type: Array(String), default: [] of String},
      color_indicator: {type: Array(String), nilable: true},
      power: {type: String, nilable: true},
      toughness: {type: String, nilable: true},
      loyalty: {type: String, nilable: true},
      flavor_text: {type: String, nilable: true},
      illustration_id: {type: UUID, nilable: true},
      image_uris: {type: Hash(String, URI), nilable: true},
    )
  end
end
