require "json"
require "uri"

# Adds JSON support to `URI` for use in a JSON mapping.
#
# NOTE: `require "uri/json"` is required to opt-in to this feature.
#
# ```
# require "json"
# require "uri"
# require "uri/json"
#
# class Example
#   JSON.mapping uri: URI
# end
#
# example = Example.from_json(%({"uri": "http://foo.com/posts?id=30&limit=5#time=1305298413"}))
#
# uri = URI.parse "http://foo.com/posts?id=30&limit=5#time=1305298413"
# uri.to_json # => "http://foo.com/posts?id=30&limit=5#time=1305298413"
# ```
class URI
  def self.new(pull : JSON::PullParser)
    URI.parse(pull.read_string)
  end

  def to_json(json : JSON::Builder)
    json.string(to_s)
  end
end
