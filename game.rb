require_relative "modules/constants"
require_relative "modules/initial_messages"
require_relative "modules/user_input"

class Game
  include Constants
  include InitialMessages
  include UserInput

  def start
    # Create a welcome method(s) to get the name, pokemon and pokemon_name from the user
    welcome_message
    name = get_input("First, what is your name?")
    welcome_player(name)
    chosen_pokemon = choose_pokemon
    chosen_pokemon_name = get_pokemon_name(chosen_pokemon)
    final_message(name, chosen_pokemon_name)

    # Then create a Player with that information and store it in @player

    # Suggested game flow
    action = menu
    until action == "exit"
      case action
      when "train"
        puts "Train"
        # train
        # action = menu
      when "leader"
        puts "Leader"
        # challenge_leader
        # action = menu
      when "stats"
        puts "Stats"
        # show_stats
        # action = menu
      end
      action = menu
    end

    goodbye
  end

  def train
    # Complete this
  end

  def challenge_leader
    # Complete this
  end

  def show_stats
    # Complete this
  end

  def goodbye
    puts "\nThanks for playing Pokemon Ruby, bye bye!"
  end

  def menu
    puts "#{'-' * 23}Menu#{'-' * 23}"
    puts ""
    puts "1. Stats        2. Train        3. Leader       4. Exit"
    print "> "
    action = gets.chomp.strip.downcase
    until MENU_OPTIONS.include?(action)
      puts "Enter a valid option"
      print "> "
      action = gets.chomp.strip.downcase
    end
    action
  end
end
