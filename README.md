# scryfall.cr

A Crystal api wrapper for https://scryfall.com

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  scryfall:
    github: kalinon/scryfall.cr
```

## Usage

```crystal
require "scryfall"

uuid = UUID.new("af8b9c79-a161-4d7d-944d-82a44a5f2ab9")

Scryfall::Api.fetch_card(uuid)
```

## Contributing

1. Fork it (<https://github.com/kalinon/scryfall.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [kalinon](https://github.com/kalinon) Holden Omans - creator, maintainer
