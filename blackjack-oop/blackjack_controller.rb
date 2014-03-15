class BlackjackController
  # Game settings
  attr_accessor :amount_decks
  # Game variables
  attr_accessor :display, :player, :dealer, :deck

  def initialize
    @display = BlackjackView.new
    @player = Player.new
    @dealer = Player.new(true)
    @dealer.name = "Dealer"
    @deck = Deck.new(2)
  end

  def run
    display.clear
    display.welcome
    
    @player.name = @display.ask_name
    if @player.name.empty?
      @player.name = "Player"
    end

    display.pause
    display.say_thankyou(@player.name)
    display.pause
    display.announce("Starting game...")
    display.pause(2)

    setup
    start_game
  end

  def setup
    render_cards(true)

    2.times do
      card = deck.take_card
      card.is_hidden = dealer.cards.empty?
      dealer.cards << card
      render_cards(true)

      player.cards << deck.take_card
      render_cards(player.cards.size < 2)
    end
  end

  def render_cards(hide_turn=false)
    display.clear
    if hide_turn
      display.display_setup_turn
    else
      display.display_player_turn(player.name)
    end
    display.display_cards(player, dealer)
    display.pause(2)
  end

  def render_dealer_cards
    display.clear
    display.display_dealer_turn
    display.display_cards(player, dealer)
    display.pause(2)
  end

  def start_game
    if check_blackjacks
      next_game
      return
    end

    choice = ''
    while 's' != choice && player.cards_points < 22 
      choice = display.ask_hit_stay
      if choice == 'h'
        player.cards << deck.take_card
        render_cards
      end
    end

    if player.cards_points > 21
      display.display_player_busted
    else

      # dealer's turn
      dealer.reveal_all_cards
      render_dealer_cards

      while dealer.cards_points < 17
        dealer.cards << deck.take_card
        render_dealer_cards
      end

      # Announce winner
      if dealer.cards_points > 21
        display.display_dealer_busted
      elsif player.cards_points > dealer.cards_points
        display.display_player_wins
      elsif player.cards_points == dealer.cards_points
        display.display_tie
      else
        display.display_player_loses
      end
    end

    next_game
  end

  def check_blackjacks

    if player.cards_points == 21 && dealer.cards_points == 21
      display.display_dealer_blackjack
      display.pause
      display.display_player_blackjack_tie
      display.pause
      display.display_tie

    elsif dealer.cards_points == 21
      display.display_dealer_blackjack
      display.pause
      display.display_player_loses

    elsif player.cards_points == 21
      display.display_player_blackjack
      display.pause(3)
      display.display_player_wins
    end

    player.cards_points == 21 || dealer.cards_points == 21
  end

  def next_game
    reset
    if display.ask_play_again == 'y'
      setup
      start_game
    else
      display.display_goodbye
    end
  end

  def reset
    player.cards.clear
    dealer.cards.clear
    @deck = Deck.new(2)
  end
end