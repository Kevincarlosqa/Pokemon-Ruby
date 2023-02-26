require_relative "modules/constants"
require_relative "modules/initial_messages"
require_relative "modules/user_input"
require_relative "player"
require_relative "battle"

class Game
  include Constants
  include InitialMessages
  include UserInput

  attr_accessor :player

  def start
    welcome_message
    name = get_input("\nFirst, what is your name?")
    welcome_player(name)
    chosen_pokemon = choose_pokemon
    chosen_pokemon_name = get_pokemon_name(chosen_pokemon)
    final_message(name, chosen_pokemon_name)

    @player = Player.new(name, chosen_pokemon, chosen_pokemon_name)

    action = menu
    until action == "exit"
      case action
      when "train"
        train
      when "leader"
        challenge_leader
      when "stats"
        show_stats
      end
      action = menu
    end

    goodbye
  end

  def train
    bot = Bot.new
    battle = Battle.new(@player, bot)
    battle.start
  end

  def challenge_leader
    leader = Leader.new
    battle = Battle.new(@player, leader)
    battle.start
  end

  def show_stats
    pokemon = @player.pokemon
    puts ""
    puts "#{pokemon.name}:"
    puts "Kind: #{pokemon.species}"
    puts "Level: #{pokemon.level}"
    puts "Type: #{pokemon.type.join(' ')}"
    puts "\nStats:"
    puts "HP: #{pokemon.stats[:hp]}"
    puts "Attack: #{pokemon.stats[:attack]}"
    puts "Defense: #{pokemon.stats[:defense]}"
    puts "Special Attack: #{pokemon.stats[:special_attack]}"
    puts "Special Defense: #{pokemon.stats[:special_defense]}"
    puts "Speed: #{pokemon.stats[:speed]}"
    puts "Experience Points: #{pokemon.experience_points}"
  end

  def goodbye
    puts ""
    puts "Thanks for playing Pokemon Ruby"
    puts "This game was created with love by: Diego L., Kevin Q., Oliver P. and Crhistian T."
  end

  def menu
    puts "\n#{'-' * 23}Menu#{'-' * 23}"
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
