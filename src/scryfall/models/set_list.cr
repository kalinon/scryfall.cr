require "./set"

module Scryfall
  struct SetList
    include JSON::Serializable
    include Enumerable(Scryfall::Set)

    getter data : Array(Set) = Array(Set).new
    getter? has_more : Bool = false

    def each
      data.each do |set|
        yield set
      end
    end
  end
end
