module Scryfall::Search
  extend self
  alias SearchParams = NamedTuple(
    card_name: String,
    card_text: String,
    card_types: Array(String),
    card_type_partial: Bool,
    card_colors: Array(Mtg::Card::Color),
    card_color_opp: String,
    commander_colors: Array(Mtg::Card::Color),
  )

  COLOR_SEARCH_MODES = {
    "Exactly these colors"   => "=",
    "Including these colors" => ">=",
    "At most these colors"   => "<=",
  }

  # Perform a scryfall search
  def search(data : SearchParams) : Scryfall::CardList
    Scryfall::Api.query(search_string(search_data))
  end

  # Convert search NamedTuple to a search string
  def search_string(data : SearchParams) : String
    String::Builder.build do |b|
      b << data[:card_name] << ' ' unless data[:card_name].empty?
      b << "o:\"" << data[:card_text] << "\" " unless data[:card_name].empty?

      unless data[:card_types].empty?
        if data[:card_type_partial]
          b << '('
          b << data[:card_types].map { |t| "t:#{t}" }.join(" OR ")
          b << ')' << ' '
        else
          data[:card_types].each do |typ|
            b << "t:" << typ.downcase << ' '
          end
        end
      end

      unless data[:card_colors].empty?
        b << 'c' << data[:card_color_opp]
        data[:card_colors].each do |c|
          b << c.to_char
        end
        b << ' '
      end

      unless data[:commander_colors].empty?
        b << "commander:"
        data[:commander_colors].each do |c|
          b << c.to_char
        end
        b << ' '
      end
    end.chomp(' ').downcase
  end
end
