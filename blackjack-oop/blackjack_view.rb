class BlackjackView

  def initialize
    @fullscreen_width = 154
    @screen_width = 77
    @inner_width = @screen_width-2

    @empty_line = "|" + String.new.ljust(@inner_width) + "|"
    @single_line = "+" + "-" * (@inner_width) + "+"
    @double_line = "+" + "=" * (@inner_width) + "+"
    @special_line = "+".center(@fullscreen_width, '=')
    @connecting_line = ''.ljust(@inner_width) + " |"

    @turn_bar_line = "+" + "+".center(@fullscreen_width-2, '-') + "+"

    @card_symbols = {clubs: "\u2667", diamonds: "\u2662", hearts: "\u2661", spades: "\u2664"}
    @clear_screen = "\u001B" + 'c'

    # Banner
    @banner = Array.new
    @banner << '|' + '  ____  _            _     _            _     '.center(@inner_width) + '|'
    @banner << '|' + ' | __ )| | __ _  ___| | __(_) __ _  ___| | __ '.center(@inner_width) + '|'
    @banner << '|' + ' |  _ \| |/ _` |/ __| |/ /| |/ _` |/ __| |/ / '.center(@inner_width) + '|'
    @banner << '|' + ' | |_) | | (_| | (__|   < | | (_| | (__|   <  '.center(@inner_width) + '|'
    @banner << '|' + ' |____/|_|\__,_|\___|_|\_\/ |\__,_|\___|_|\_\ '.center(@inner_width) + '|'
    @banner << '|' + '                        |__/                  '.center(@inner_width) + '|'

    @blackjack = Array.new
    @blackjack << '|' + ' __       ___                    __                             __         ' + '|'
    @blackjack << '|' + '/\ \     /\_ \                  /\ \        __                 /\ \        ' + '|'
    @blackjack << '|' + '\ \ \____\//\ \      __      ___\ \ \/\'\   /\_\     __      ___\ \ \/\'\    ' + '|'
    @blackjack << '|' + ' \ \ \'__`\ \ \ \   /\'__`\   /\'___\ \ , <   \/\ \  /\'__`\   /\'___\ \ , <    ' + '|'
    @blackjack << '|' + '  \ \ \L\ \ \_\ \_/\ \L\.\_/\ \__/\ \ \\\\`\  \ \ \/\ \L\.\_/\ \__/\ \ \\\\`\  ' + '|'
    @blackjack << '|' + '   \ \_,__/ /\____\ \__/.\_\ \____\\\\ \_\ \_\_\ \ \ \__/.\_\ \____\\\\ \_\ \_\\' + '|'
    @blackjack << '|' + '    \/___/  \/____/\/__/\/_/\/____/ \/_/\/_/\ \_\ \/__/\/_/\/____/ \/_/\/_/' + '|'
    @blackjack << '|' + '                                           \ \____/                        ' + '|'
    @blackjack << '|' + '                                            \/___/                         ' + '|'

    # Text lines
    @text1_line = "|" + "Welcome to the Blackjack table.".center(@inner_width) + "|"
    @text2_line = "|" + "Lets play a game of Blackjack, shall we?".center(@inner_width) + "|"
    @text3_line = "|" + "Please enter your name".center(@inner_width) + "|"
    @text7_line = "Do you want to hit (h) or stay (s) ?".center(@inner_width)
    @text8_line = "Please enter 'h' or 's'".center(@inner_width)
    @text9_line = "Do you want to play again, yes (y) or no (n) ?".center(@inner_width)
    @text10_line = "Please enter 'y' or 'n'".center(@inner_width)
    @text11_line = "|" + "Goodbye and thank you for playing".center(@inner_width) + "|"

    @input_cursor = "|      => "
    @input_cursor = @input_cursor.rjust((@screen_width / 2) + @input_cursor.size)

    @center_cursor = "=> ".rjust(@inner_width)

    @card_display = Array.new
    @card_display << ''
    @card_display << '  ___________  '
    @card_display << ' /           \ '
    @card_display << ' | ??     ?? | '
    @card_display << ' | #       # | '
    @card_display << ' |           | '
    @card_display << ' |     #     | '
    @card_display << ' |           | '
    @card_display << ' | #       # | '
    @card_display << ' | ??     ?? | '
    @card_display << ' \___________/ '

    @card_display_hidden = Array.new
    @card_display_hidden << ''
    @card_display_hidden << '  ___________  '
    @card_display_hidden << ' /           \ '
    @card_display_hidden << ' | /  /  /  /| '
    @card_display_hidden << ' |/  /  /  / | '
    @card_display_hidden << ' |  /  /  /  | '
    @card_display_hidden << ' | /  /  /  /| '
    @card_display_hidden << ' |/  /  /  / | '
    @card_display_hidden << ' |  /  /  /  | '
    @card_display_hidden << ' | /  /  /  /| '
    @card_display_hidden << ' \___________/ '
  end

  def center_puts(str)
    puts str.center(@fullscreen_width)
  end

  def welcome
    pause
    center_puts @single_line
    center_puts @empty_line
    @banner.each { |line| center_puts line }
    center_puts @empty_line
    center_puts @text1_line
    center_puts @empty_line
    center_puts @single_line
    pause
    center_puts @empty_line
    center_puts @text2_line
    center_puts @empty_line
    center_puts @double_line
    pause
    
  end

  def ask_name
    center_puts @empty_line
    center_puts @empty_line
    center_puts @text3_line
    center_puts @empty_line
    print @input_cursor
    gets.chomp
  end

  def say_thankyou(name)
    @thankyou_line = "|" + "Thank you, #{name}".center(@inner_width) + "|"

    center_puts @empty_line
    center_puts @thankyou_line
    center_puts @empty_line
    center_puts @single_line
  end

  def ask_hit_stay
    choice = nil

    center_puts @single_line
    puts
    center_puts @text7_line
    puts
    
    while choice == nil
      print @center_cursor
      input = gets.chomp
      if input.downcase == 'h' || input.downcase == 's'
        choice = input
      else
        puts
        center_puts @text8_line
        puts
      end
    end

    choice
  end

  def ask_play_again
    choice = nil

    puts @connecting_line
    center_puts @single_line
    puts
    center_puts @text9_line
    puts

    while choice == nil
      print @center_cursor
      input = gets.chomp
      if input.downcase == 'y' || input.downcase == 'n'
        choice = input
      else
        puts
        center_puts @text10_line
        puts
      end
    end
    choice
  end

  def announce(text,connection=true)
    text_line = "|" + text.center(@inner_width) + "|"

    if connection
      puts @connecting_line
    end
    center_puts @single_line
    center_puts text_line
    center_puts @single_line
  end

  ##
  # Display cards from the player and the dealer
  def display_cards(player, dealer)
    puts @connecting_line
    line_number = 0

    players = [player, dealer]

    @card_display.each do |card_line|
      line = String.new
      name_label = String.new
      cards_render = String.new

      players.each do |player|
        if line_number == 0
          # print name label
          name_label = " #{player.name} "
          name_label += " (#{player.cards_points})" if player.cards_points > 0 && !player.has_hidden_card? && player.cards.size >= 2
          
          if player.is_dealer
            line += name_label.rjust(@inner_width)
          else
            line += name_label.ljust(@inner_width)
          end

        else
          
          # print cards
          cards_render = ''
          player.cards.each do |card|
            card_symbol = @card_symbols[card.suit.to_sym]
            if card.is_hidden
              cards_render += @card_display_hidden[line_number]
            else
              cards_render += card_line 
                                .sub('??', card.value.ljust(2))
                                .sub('??', card.value.rjust(2))
                                .gsub('#',card_symbol)
            end
          end

          line += cards_render.center(@inner_width)
        end

        if !player.is_dealer
          line += " |"
        end
      end

      puts line
      line_number += 1
    end

    puts @connecting_line
    puts @connecting_line
  end

  def display_player_busted
    announce "YOU'VE BUSTED! GAME OVER!"
  end

  def display_setup_turn
    display_turn_bar('')
  end

  def display_player_turn(name="Player")
    text = "#{name}'s turn"
    display_turn_bar(text, true)
  end

  def display_dealer_turn
    text = "Dealer's turn"
    display_turn_bar(text, false)
  end

  def display_turn_bar(text, left=true)
    puts @turn_bar_line
    if left
      text_line = "|" + text.center(@inner_width) + "|"
      puts text_line.ljust(@fullscreen_width-2) + " |"
    else
      text_line = "|" + text.center(@inner_width) + " |"
      puts "| " + (text_line).rjust(@fullscreen_width-2)
    end
    puts @turn_bar_line
  end

  def display_dealer_blackjack
    announce "DEALER HAS BLACKJACK!"
  end

  def display_player_blackjack_tie
    announce "YOU HAVE ALSO BLACKJACK!"
  end

  def display_player_blackjack
    puts @connecting_line
    center_puts @single_line
    center_puts @empty_line
    @blackjack.each { |line| center_puts line }
    center_puts @empty_line
    center_puts @single_line
  end

  def display_dealer_busted
    announce "DEALER BUSTED! YOU WIN!"
  end

  def display_player_wins
    announce "YOU WIN THIS GAME!"
  end

  def display_tie
    announce "TIE! NOBODY WINS!"
  end

  def display_player_loses
    announce "YOU'VE LOST!"
  end

  def display_goodbye
    clear
    puts
    puts
    center_puts @single_line
    center_puts @empty_line
    center_puts @text11_line
    center_puts @empty_line
    @banner.each { |line| center_puts line }
    center_puts @empty_line
    center_puts @single_line
    puts
    puts
    puts
    pause
  end

  def pause(secs=1)
    sleep(secs)
  end

  def clear
    print @clear_screen
  end

end