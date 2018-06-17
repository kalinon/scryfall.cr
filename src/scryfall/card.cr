module Scryfall
  struct Card
    property id, name, rarity, set, uri

    def initialize(@id : UUID, @name : String, @rarity : String, @set : String, @uri : String)
    end
  end
end
