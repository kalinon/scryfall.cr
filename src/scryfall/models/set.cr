require "json"

module Scryfall
  struct Set
    include JSON::Serializable
    property object : String
    property id : UUID
    property code : String
    property mtgo_code : String? = nil
    property arena_code : String? = nil
    property tcgplayer_id : Int32? = nil
    property name : String
    property uri : String
    property scryfall_uri : String
    property search_uri : String
    property released_at : String? = nil
    property set_type : String
    property card_count : Int32
    property parent_set_code : String
    property digital : Bool
    property nonfoil_only : Bool
    property foil_only : Bool
    property icon_svg_uri : String

    property block_code : String? = nil
    property block : String? = nil
    property parent_set_code : String? = nil

    property printed_size : Int32? = nil

  end
end
