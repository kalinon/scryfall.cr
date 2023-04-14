require "../../spec_helper"

describe Scryfall::CardFace do
  faces_1_json = [
    {
      "artist": "Henry Peters",
      "colors": [
        "B",
        "W",
      ],
      "illustration_id": "e505aa78-b014-44aa-bee3-cb4f7dc587f0",
      "image_uris":      {
        "small":       "https://cards.scryfall.io/small/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "normal":      "https://cards.scryfall.io/normal/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "large":       "https://cards.scryfall.io/large/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "png":         "https://cards.scryfall.io/png/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.png?1680875504",
        "art_crop":    "https://cards.scryfall.io/art_crop/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "border_crop": "https://cards.scryfall.io/border_crop/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
      },
      "mana_cost":         "{3}{W}{B}",
      "name":              "Invasion of Tolvada",
      "object":            "card_face",
      "oracle_text":       "(As a Siege enters, choose an opponent to protect it. You and others can attack it. When it's defeated, exile it, then cast it transformed.)\nWhen Invasion of Tolvada enters the battlefield, return target nonbattle permanent card from your graveyard to the battlefield.",
      "printed_type_line": "",
      "type_line":         "Battle — Siege",
      "watermark":         "",
    },
    {
      "artist": "Henry Peters",
      "colors": [
        "B",
        "W",
      ],
      "color_indicator": [
        "B",
        "W",
      ],
      "flavor_text":     "Angry ghosts poured through and pummeled the Invasion Tree, filling the heavens with the rhythms of war.",
      "illustration_id": "e61d567e-03dc-4c8a-a773-65ae8cd7fdc9",
      "image_uris":      {
        "small":       "https://cards.scryfall.io/small/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "normal":      "https://cards.scryfall.io/normal/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "large":       "https://cards.scryfall.io/large/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "png":         "https://cards.scryfall.io/png/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.png?1680875504",
        "art_crop":    "https://cards.scryfall.io/art_crop/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "border_crop": "https://cards.scryfall.io/border_crop/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
      },
      "mana_cost":         "",
      "name":              "The Broken Sky",
      "object":            "card_face",
      "oracle_text":       "Creature tokens you control get +1/+0 and have lifelink.\nAt the beginning of your end step, create a 1/1 white and black Spirit creature token with flying.",
      "printed_type_line": "",
      "type_line":         "Enchantment",
      "watermark":         "",
    },
  ].to_json
  faces_2_json = [
    {
      "artist": "Henry Peters",
      "colors": [
        "B",
        "W",
      ],
      "illustration_id": "e505aa78-b014-44aa-bee3-cb4f7dc587f0",
      "image_uris":      {
        "small":       "https://cards.scryfall.io/small/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "normal":      "https://cards.scryfall.io/normal/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "large":       "https://cards.scryfall.io/large/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "png":         "https://cards.scryfall.io/png/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.png?1680875504",
        "art_crop":    "https://cards.scryfall.io/art_crop/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "border_crop": "https://cards.scryfall.io/border_crop/front/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
      },
      "mana_cost":         "{3}{W}{B}",
      "name":              "Invasion of Tolvada",
      "object":            "card_face",
      "oracle_text":       "(As a Siege enters, choose an opponent to protect it. You and others can attack it. When it's defeated, exile it, then cast it transformed.)\nWhen Invasion of Tolvada enters the battlefield, return target nonbattle permanent card from your graveyard to the battlefield.",
      "printed_type_line": "",
      "type_line":         "Battle — Siege",
      "watermark":         "",
      "defense":           "5",
    },
    {
      "artist": "Henry Peters",
      "colors": [
        "B",
        "W",
      ],
      "color_indicator": [
        "B",
        "W",
      ],
      "flavor_text":     "Angry ghosts poured through and pummeled the Invasion Tree, filling the heavens with the rhythms of war.",
      "illustration_id": "e61d567e-03dc-4c8a-a773-65ae8cd7fdc9",
      "image_uris":      {
        "small":       "https://cards.scryfall.io/small/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "normal":      "https://cards.scryfall.io/normal/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "large":       "https://cards.scryfall.io/large/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "png":         "https://cards.scryfall.io/png/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.png?1680875504",
        "art_crop":    "https://cards.scryfall.io/art_crop/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
        "border_crop": "https://cards.scryfall.io/border_crop/back/0/0/00255899-aaaf-46c6-8037-bd0e3c06250c.jpg?1680875504",
      },
      "mana_cost":         "",
      "name":              "The Broken Sky",
      "object":            "card_face",
      "oracle_text":       "Creature tokens you control get +1/+0 and have lifelink.\nAt the beginning of your end step, create a 1/1 white and black Spirit creature token with flying.",
      "printed_type_line": "",
      "type_line":         "Enchantment",
      "watermark":         "",
    },
  ].to_json

  it "#==" do
    faces_1 = Array(Scryfall::CardFace).from_json(faces_1_json)
    faces_2 = Array(Scryfall::CardFace).from_json(faces_2_json)
    (faces_1 == faces_2).should be_false
    (faces_1[0] == faces_2[0]).should be_false
    (faces_1[1] == faces_2[1]).should be_true
    (faces_1[0] == faces_2[1]).should be_false
  end
end
