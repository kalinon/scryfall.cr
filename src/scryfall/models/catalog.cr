require "json"

class Catalog
  include JSON::Serializable

  property object : String
  property uri : String
  property total_values : Int32
  property data : Array(String)
end
