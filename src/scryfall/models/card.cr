require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"
require "./card_face"
require "./related_card"

module Scryfall
  struct Card
    # Core Card Fields
    include JSON::Serializable

    property id : UUID
    property oracle_id : UUID
    property multiverse_ids : Array(Int32)? = nil
    property mtgo_id : Int32? = nil
    property mtgo_foil_id : Int32? = nil
    property arena_id : Int32? = nil
    property uri : URI
    property scryfall_uri : URI
    property prints_search_uri : URI
    property rulings_uri : URI

    # Gameplay Fields
    property name : String
    property layout : String
    property cmc : Float32
    property type_line : String
    property oracle_text : String? = nil
    property mana_cost : String = ""
    property power : String? = nil
    property toughness : String? = nil
    property loyalty : String? = nil
    property life_modifier : String? = nil
    property hand_modifier : String? = nil
    property colors : Array(String) = Array(String).new
    property color_indicator : Array(String)? = nil
    property all_parts : Array(Scryfall::RelatedCard)? = nil
    property legalities : Hash(String, String)
    property reserved : Bool
    property foil : Bool
    property nonfoil : Bool
    property oversized : Bool
    property edhrec_rank : Int32? = nil

    # Print Fields
    property set : String
    property set_name : String
    property collector_number : String
    property set_search_uri : URI
    property scryfall_set_uri : URI
    property image_uris : Hash(String, URI)? = nil
    property highres_image : Bool
    property printed_name : String = ""
    property printed_type_line : String = ""
    property printed_text : String = ""
    property reprint : Bool
    property digital : Bool
    property rarity : String
    property flavor_text : String? = nil
    property artist : String? = nil
    property illustration_id : URI? = nil
    property frame : String
    property full_art : Bool
    property watermark : String? = nil
    property border_color : String
    property story_spotlight_number : Int32? = nil
    property story_spotlight_uri : URI? = nil

    property card_faces : Array(Scryfall::CardFace)? = nil
    property related_cards : Array(Scryfall::RelatedCard)? = nil
  end
end
