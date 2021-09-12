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

    getter arena_id : Int32? = nil
    getter id : UUID
    getter lang : String
    getter mtgo_id : Int32? = nil
    getter mtgo_foil_id : Int32? = nil
    getter multiverse_ids : Array(Int32)? = nil
    getter tcgplayer_id : Int32? = nil
    getter tcgplayer_id : Int32? = nil
    getter object : String
    getter oracle_id : UUID
    getter prints_search_uri : URI
    getter rulings_uri : URI
    getter scryfall_uri : URI
    getter uri : URI

    # Gameplay Fields
    getter all_parts : Array(Scryfall::RelatedCard) = Array(Scryfall::RelatedCard).new
    getter card_faces : Array(Scryfall::CardFace) = Array(Scryfall::CardFace).new
    getter cmc : Float32
    getter color_identity : Array(String)
    getter color_indicator : Array(String) = Array(String).new
    getter colors : Array(String) = Array(String).new
    getter edhrec_rank : Int32? = nil
    getter hand_modifier : String? = nil
    getter keywords : Array(String) = Array(String).new
    getter layout : String
    getter legalities : Hash(String, String)
    getter life_modifier : String? = nil
    getter loyalty : String? = nil
    getter mana_cost : String? = nil
    getter name : String
    # getter? foil : Bool
    # getter? nonfoil : Bool
    getter finishes: Array(String) = Array(String).new
    getter oracle_text : String? = nil
    getter? oversized : Bool
    getter power : String? = nil
    getter produced_mana : Array(String) = Array(String).new
    getter type_line : String
    getter? reserved : Bool
    getter toughness : String? = nil
    getter type_line : String

    # Print Fields
    getter artist : String? = nil
    getter? booster : Bool
    getter border_color : String
    getter card_back_id : UUID
    getter collector_number : String
    getter? content_warning : Bool = false
    getter? digital : Bool
    getter flavor_name : String? = nil
    getter flavor_text : String? = nil
    getter frame_effects : Array(String) = Array(String).new
    getter frame : String
    getter? full_art : Bool
    getter games : Array(String) = Array(String).new
    getter? highres_image : Bool
    getter illustration_id : URI? = nil
    getter image_uris : Hash(String, URI) = Hash(String, URI).new
    getter prices : Hash(String, String?)
    getter printed_name : String? = nil
    getter printed_text : String? = nil
    getter printed_type_line : String? = nil
    getter? promo : Bool
    getter promo_types : Array(String) = Array(String).new
    getter purchase_uris : Hash(String, String)
    getter rarity : String
    getter related_uris : Hash(String, String)
    getter released_at : String
    getter? reprint : Bool
    getter set_search_uri : URI
    getter set_name : String
    getter set_type : String
    getter set_uri : URI
    getter set : String
    getter? story_spotlight : Bool
    getter? textless : Bool
    getter? variation : Bool
    getter variation_of : UUID? = nil
    getter watermark : String? = nil
    getter preview : Hash(String, String) = Hash(String, String).new
  end
end
