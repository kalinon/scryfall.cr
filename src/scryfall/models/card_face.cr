require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"

module Scryfall
  struct CardFace
    include JSON::Serializable

    getter artist : String? = nil
    getter colors : Array(String) = Array(String).new
    getter color_indicator : Array(String)? = nil
    getter flavor_text : String? = nil
    getter illustration_id : UUID? = nil
    getter image_uris : Hash(String, URI)? = nil
    getter mana_cost : String
    getter cmc : Float32? = nil
    getter name : String
    getter object : String
    getter oracle_text : String? = nil
    getter printed_name : String? = nil
    getter printed_text : String? = nil
    getter printed_type_line : String = ""
    getter type_line : String = ""
    getter watermark : String = ""

    getter power : String? = nil
    getter toughness : String? = nil
    getter loyalty : String? = nil
    getter defense : String? = nil

    def_equals :name, :type_line, :oracle_text, :mana_cost, :power, :toughness, :loyalty,
      :defense, :flavor_text, :artist, :illustration_id,
      :image_uris, :cmc, :colors, :color_indicator, :watermark,
      :printed_name, :printed_text, :printed_type_line
  end
end
