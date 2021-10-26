require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"

module Scryfall
  struct RelatedCard
    include JSON::Serializable

    property id : UUID
    property object : String
    property component : String
    property name : String
    property type_line : String
    property uri : URI
  end
end
