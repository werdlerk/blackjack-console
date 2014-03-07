require 'pry'

@card_types_values = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10]
@card_types = ["ace", "2", "3", "4", "5", "6", "7", "8", "9", "jack", "queen", "king"]
@card_types_short = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K"]
@card_suits = ["clubs", "diamonds", "hearts", "spades"]
@card_symbols = ["\u2667", "\u2662", "\u2661", "\u2664"]

@fullscreen_width = 154
@screen_width = 77
@inner_width = @screen_width-2

@random_seed = Random.new_seed
@player_name = "Player"

@player_cards = []
@dealer_cards = []
@play_again = true

def center_puts str
  puts str.center(@fullscreen_width)
end

def welcome
  single_line = "+" + "-" * (@inner_width) + "+"
  double_line = "+" + "=" * (@inner_width) + "+"
  empty_line = "|" + String.new.ljust(@inner_width) + "|"
  text1_line = "|" + "Welcome to the Blackjack table.".center(@inner_width) + "|"
  text2_line = "|" + "Lets play a game of Blackjack, shall we?".center(@inner_width) + "|"
  text3_line = "|" + "Please enter your name".center(@inner_width) + "|"
  banner = Array.new
  banner << '|' + '  ____  _            _     _            _     '.center(@inner_width) + '|'
  banner << '|' + ' | __ )| | __ _  ___| | __(_) __ _  ___| | __ '.center(@inner_width) + '|'
  banner << '|' + ' |  _ \| |/ _` |/ __| |/ /| |/ _` |/ __| |/ / '.center(@inner_width) + '|'
  banner << '|' + ' | |_) | | (_| | (__|   < | | (_| | (__|   <  '.center(@inner_width) + '|'
  banner << '|' + ' |____/|_|\__,_|\___|_|\_\/ |\__,_|\___|_|\_\ '.center(@inner_width) + '|'
  banner << '|' + '                        |__/                  '.center(@inner_width) + '|'
  input_cursor = "|      => "
  input_cursor = input_cursor.rjust((@screen_width / 2) + input_cursor.size)

  pause
  center_puts single_line
  center_puts empty_line
  banner.each { |line| center_puts line }
  center_puts empty_line
  center_puts text1_line
  center_puts empty_line
  center_puts single_line
  pause
  center_puts empty_line
  center_puts text2_line
  center_puts empty_line
  center_puts double_line
  pause
  center_puts empty_line
  center_puts empty_line
  center_puts text3_line
  center_puts empty_line
  print input_cursor
  player_name = gets.chomp
  @player_name = player_name unless player_name.empty?
  pause

  text4_line = "|" + "Thank you, #{@player_name}".center(@inner_width) + "|"

  center_puts empty_line
  center_puts text4_line
  center_puts empty_line
  pause
end

def ask_game_number
  empty_line = "|" + String.new.ljust(@inner_width) + "|"
  text5_line = "|" + "Do you wish to replay a certain game number?".center(@inner_width) + "|"
  text6_line = "|" + "We play a random game if you enter no (valid) game number.".center(@inner_width) + "|"
  single_line = "+" + "-" * (@inner_width) + "+"
  special_line = "+".center(@fullscreen_width, '=')
  input_cursor = "|      => "
  input_cursor = input_cursor.rjust((@screen_width / 2) + input_cursor.size)

  center_puts single_line
  center_puts empty_line
  center_puts text5_line
  center_puts text6_line
  center_puts empty_line
  print input_cursor
  seed = gets.chomp
  @random_seed = seed.to_i if seed.to_i.to_s == seed unless seed.empty?
  pause
  center_puts single_line
  center_puts special_line
end

def ask_hit_stay
  single_line = "+" + "-" * (@inner_width) + "+"
  empty_line = "|" + String.new.ljust(@inner_width) + "|"
  text1_line = "|" + "Do you want to hit (h) or stay (s) ?".center(@inner_width) + "|"
  text2_line = "|" + "Please enter 'h' or 's'".center(@inner_width) + "|"
  input_cursor = "|      => "
  input_cursor = input_cursor.rjust((@screen_width / 2) + input_cursor.size)
  choice = nil

  center_puts single_line
  center_puts empty_line
  center_puts text1_line
  center_puts empty_line
  
  while choice == nil
    print input_cursor
    input = gets.chomp
    if input.downcase == 'h' || input.downcase == 's'
      choice = input
    else
      center_puts empty_line
      center_puts text2_line
      center_puts empty_line
    end
  end

  center_puts empty_line
  center_puts single_line
  choice
end

def ask_play_again
  connecting_line = ''.ljust(@inner_width) + " |"
  empty_line = "|" + String.new.ljust(@inner_width) + "|"
  text1_line = "|" + "Do you want to play again, yes (y) or no (n) ?".center(@inner_width) + "|"
  text2_line = "|" + "Please enter 'y' or 'n'".center(@inner_width) + "|"
  single_line = "+" + "-" * (@inner_width) + "+"
  special_line = "+".center(@fullscreen_width, '=')
  input_cursor = "|      => "
  input_cursor = input_cursor.rjust((@screen_width / 2) + input_cursor.size)
  choice = nil

  puts connecting_line
  center_puts single_line
  center_puts empty_line
  center_puts text1_line
  center_puts empty_line

  while choice == nil
    print input_cursor
    input = gets.chomp
    if input.downcase == 'y' || input.downcase == 'n'
      choice = input
    else
      center_puts empty_line
      center_puts text2_line
      center_puts empty_line
    end
  end

  center_puts empty_line
  choice
end

def announce text,connection=true
  connecting_line = ''.ljust(@inner_width) + " |"
  single_line = "+" + "-" * (@inner_width) + "+"
  empty_line = "|" + String.new.ljust(@inner_width) + "|"
  text_line = "|" + text.center(@inner_width) + "|"

  if connection
    puts connecting_line
  end
  center_puts single_line
  # center_puts empty_line
  center_puts text_line
  # center_puts empty_line
  center_puts single_line
end

def pause
   sleep(1)
end


def pick_card
  card = {}
  type_rand = rand(@card_types.size)
  card[:type] = @card_types[type_rand]
  card[:suit] = @card_suits[rand(@card_suits.size)]
  card[:type_short] = @card_types_short[type_rand]
  card[:hidden] = false
  card
end

def card_value(card)
  return @card_types_values[@card_types.index(card[:type])]
end

def cards_total_value(cards)
  aces_count = 0
  total_value = 0

  cards.each do |card| 
    value = card_value(card)
    if (value == 11)
      aces_count += 1
    end
    total_value += value
  end

  # Take into account any aces if the total value is higher then 21
  while total_value > 21 && aces_count > 0
    total_value -= 10
    aces_count -= 1
  end

  total_value
end

def deal_card(user_cards)
  user_cards << pick_card
  user_cards.last
end

def has_hidden_card?(user_cards)
  hidden_card = false

  user_cards.each do |card|
    if card[:hidden]
      hidden_card = true
      break
    end
  end

  hidden_card
end

##
# Display cards from the player and the dealer
def display_cards
  connecting_line = ''.ljust(@inner_width) + " |"
  card_display = Array.new
  card_display << ''
  card_display << '  ___________  '
  card_display << ' /           \ '
  card_display << ' | ?       ? | '
  card_display << ' | #       # | '
  card_display << ' |           | '
  card_display << ' |     #     | '
  card_display << ' |           | '
  card_display << ' | #       # | '
  card_display << ' | ?       ? | '
  card_display << ' \___________/ '

  card_display_hidden = Array.new
  card_display_hidden << ''
  card_display_hidden << '  ___________  '
  card_display_hidden << ' /           \ '
  card_display_hidden << ' | /  /  /  /| '
  card_display_hidden << ' |/  /  /  / | '
  card_display_hidden << ' |  /  /  /  | '
  card_display_hidden << ' | /  /  /  /| '
  card_display_hidden << ' |/  /  /  / | '
  card_display_hidden << ' |  /  /  /  | '
  card_display_hidden << ' | /  /  /  /| '
  card_display_hidden << ' \___________/ '

  line_number = 0

  card_display.each do |card_line|
    line = String.new

    if line_number == 0  
      line += " #{@player_name} "
      line += " (#{cards_total_value(@player_cards)})" if cards_total_value(@player_cards) > 0
    else
      @player_cards.each do |card|
        card_symbol = @card_symbols[@card_suits.index(card[:suit])]
        card_type_short = card[:type_short]
        line += card_line.gsub('?',card_type_short).gsub('#',card_symbol)
      end
    end

    line = line.ljust(@inner_width) + " |"

    if line_number == 0
      line += " Dealer ".rjust(@inner_width)
      line += " (#{cards_total_value(@dealer_cards)})" unless has_hidden_card?(@dealer_cards)
    else
      @dealer_cards.each do |card|
        card_symbol = @card_symbols[@card_suits.index(card[:suit])]
        card_type_short = card[:type_short]
        if card[:hidden]
          line += card_display_hidden[line_number]
        else
          line += card_line.gsub('?',card_type_short).gsub('#',card_symbol)
        end
      end
    end

    puts line
    line_number += 1
  end

  puts connecting_line

end

def reset_game
  @random_seed = Random.new_seed

  @dealer_cards.clear
  @player_cards.clear
end


welcome

while @play_again
  ask_game_number
  pause

  # fix rand
  srand @random_seed

  # setup dealer
  deal_card(@dealer_cards)
  deal_card(@dealer_cards)
  @dealer_cards.last[:hidden] = true
  # check if dealer has blackjack

  # setup player
  deal_card(@player_cards)
  deal_card(@player_cards)
  display_cards

  choice = ''

  # player's turn
  pause
  while choice != 's' && cards_total_value(@player_cards) < 22 
    choice = ask_hit_stay
    if choice == 'h'
      deal_card(@player_cards)
      display_cards
    end
  end

  if cards_total_value(@player_cards) > 21
    announce "YOU'VE BUSTED! GAME OVER!"

  else 

    # dealer's turn
    announce "Dealer's turn"
    pause

    @dealer_cards.last[:hidden] = false
    display_cards
    pause
    pause

    while cards_total_value(@dealer_cards) < 17
      deal_card(@dealer_cards)
      display_cards
      pause
      pause
    end

    if cards_total_value(@dealer_cards) > 21
      announce "DEALER BUSTED! YOU WIN!"
    elsif cards_total_value(@player_cards) > cards_total_value(@dealer_cards)
      announce "YOU WIN THIS GAME!"
    elsif cards_total_value(@player_cards) == cards_total_value(@dealer_cards)
      announce "TIE! NOBODY WINS!"
    else
      announce "YOU'VE LOST!"
    end
  end

  pause
  pause

  reset_game
  @play_again = (ask_play_again == 'y')
end

announce("Thanks for playing, goodbye!", false)
