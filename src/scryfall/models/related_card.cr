require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"

module Scryfall
  struct RelatedCard
    include JSON::Serializable

    property id : UUID
    property name : String
    property uri : URI
  end
end
