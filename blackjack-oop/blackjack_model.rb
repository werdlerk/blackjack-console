class Card
  attr_accessor :suit, :value, :points
  attr_accessor :is_hidden

  def initialize(suit, value)
    @suit = suit
    @value = value
    @points = point_mapping(value)
    @is_hidden = false
  end

  def point_mapping(value)
    return value.to_i unless value.to_i == 0

    case value
      when 'A'; 11
      when 'J', 'Q', 'K'; 10
    end
  end

  def is_ace?
    @value == 'A'
  end

end


class Deck
  attr_accessor :cards

  def initialize(amount_decks=1)
    @cards = []
    # For each amount_decks, create the deck using an array of suits and an array of values
    amount_decks.times do
      ['hearts','diamonds','spades','clubs'].each do |suit|
        ['A','2','3','4','5','6','7','8','9','10','J','Q','K'].each do |value|
          @cards << Card.new(suit, value)
        end
      end
    end

    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def take_card
    @cards.pop
  end

end

class Player
  attr_accessor :name
  attr_accessor :is_dealer
  attr_accessor :cards

  def initialize(is_dealer=false)
    @is_dealer = is_dealer
    @cards = []

    if is_dealer
      name = "Dealer"
    else
      name = "Player"
    end
  end

  def cards_points
    aces_count = 0
    total_points = 0

    cards.each do |card| 
      total_points += card.points
    end

    # Take into account any aces if the total value is higher then 21
    cards.select{ |card| card.is_ace? }.count.times do
      total_points -= 10 if total_points > 21
    end

    total_points
  end

  def has_hidden_card?
    cards.select { |card| card.is_hidden }.size > 0
  end

  def reveal_all_cards
    cards.each { |card| card.is_hidden = false }
  end

end