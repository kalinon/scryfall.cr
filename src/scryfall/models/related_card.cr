require "json"
require "uuid"
require "uuid/json"
require "../../ext/uri/json"

module Scryfall
  struct RelatedCard
    JSON.mapping(
      id: UUID,
      name: String,
      uri: URI
    )
  end
end
