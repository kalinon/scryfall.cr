require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"
require "./card_face"
require "./related_card"

module Scryfall
  struct Card
    JSON.mapping(
      # Core Card Fields
      id: UUID,
      oracle_id: UUID,
      multiverse_ids: {type: Array(Int32), nilable: true},
      mtgo_id: {type: Int32, nilable: true},
      mtgo_foil_id: {type: Int32, nilable: true},
      arena_id: {type: Int32, nilable: true},
      uri: URI,
      scryfall_uri: URI,
      prints_search_uri: URI,
      rulings_uri: URI,

      # Gameplay Fields
      name: String,
      layout: String,
      cmc: Float32,
      type_line: String,
      oracle_text: {type: String, nilable: true},
      mana_cost: String,
      power: {type: String, nilable: true},
      toughness: {type: String, nilable: true},
      loyalty: {type: String, nilable: true},
      life_modifier: {type: String, nilable: true},
      hand_modifier: {type: String, nilable: true},
      colors: Array(String),
      color_indicator: {type: Array(String), nilable: true},
      all_parts: {type: Array(String), nilable: true},
      legalities: Hash(String, String),
      reserved: Bool,
      foil: Bool,
      nonfoil: Bool,
      oversized: Bool,
      edhrec_rank: {type: Int32, nilable: true},

      # Print Fields
      set: String,
      set_name: String,
      collector_number: String,
      set_search_uri: URI,
      scryfall_set_uri: URI,
      image_uris: {type: Hash(String, URI), nilable: true},
      highres_image: Bool,
      printed_name: {type: String, default: ""},
      printed_type_line: {type: String, default: ""},
      printed_text: {type: String, default: ""},
      reprint: Bool,
      digital: Bool,
      rarity: String,
      flavor_text: {type: String, nilable: true},
      artist: {type: String, nilable: true},
      illustration_id: {type: URI, nilable: true},
      frame: String,
      full_art: Bool,
      watermark: {type: String, nilable: true},
      border_color: String,
      story_spotlight_number: {type: Int32, nilable: true},
      story_spotlight_uri: {type: URI, nilable: true},
      timeshifted: Bool,
      colorshifted: Bool,
      futureshifted: Bool,

      card_faces: {type: Array(Scryfall::CardFace), nilable: true},
      related_cards: {type: Array(Scryfall::RelatedCard), nilable: true},
    )
  end
end
