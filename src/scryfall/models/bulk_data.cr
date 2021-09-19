module Scryfall
  struct BulkData
    include JSON::Serializable

    property object : String
    property id : UUID
    @[JSON::Field(key: "type")]
    property datum_type : String
    property updated_at : String
    property uri : String
    property name : String
    property description : String
    property compressed_size : Int32
    property download_uri : String
    property content_type : String
    property content_encoding : String
  end

  struct BulkDataList
    include JSON::Serializable
    include Enumerable(BulkData)

    getter object : String
    getter? has_more : Bool = false
    getter data : Array(BulkData)

    def each
      data.each do |i|
        yield i
      end
    end
  end
end
