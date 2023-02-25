require_relative "modules/constants"
require_relative "pokedex/moves"

class Battle
  include Pokedex
# (complete parameters)
include Constants
  def initialize(player, bot)
    @player = player
    @bot = bot
    @winning = nil
  end

  def start
    # Prepare the Battle (print messages and prepare pokemons)
    @player.pokemon.prepare_for_battle
    @bot.pokemon.prepare_for_battle
    message =<<-DELIMETER
#{@player.name} challenge #{@bot.name} for training
#{@bot.name} has a #{@bot.pokemon.name} level #{@bot.pokemon.level}
What do you want to do now?
    DELIMETER
    puts message
    puts ""
    puts "1. Fight        2. Leave"
    print "> "
    option = gets.chomp.downcase
    unless TRAIN_OPTIONS.include?(option)
      print "> "
      option = gets.chomp.downcase
    end
    return if option == "leave"
    puts "\n#{@bot.name} sent out #{@bot.pokemon.species.upcase}!"
    puts "#{@player.name} sent out #{@player.pokemon.species.upcase}!"
    puts "-------------------Battle Start!-------------------"
    until @player.pokemon.fainted? || @bot.pokemon.fainted?
      battle_status(@player,@bot)
      puts "#{@player.name}, select your move:"
      @player.select_move
      @bot.select_move
      puts "--------------------------------------------------"
      first_attacker = turn_order(@player,@bot)
      second_attacker = first_attacker == @player ? @bot : @player
      first_attacker.pokemon.attack(second_attacker.pokemon)
      second_attacker.pokemon.attack(first_attacker.pokemon) unless second_attacker.pokemon.fainted?
    end

  end

  def turn_order(player,bot)
    player_move = player.pokemon.current_move
    bot_move = bot.pokemon.current_move
    return player if MOVES[player_move][:priority] > MOVES[bot_move][:priority]
    return bot if MOVES[player_move][:priority] < MOVES[bot_move][:priority]
    if player.pokemon.stats[:speed] > bot.pokemon.stats[:speed]
      return player
    elsif player.pokemon.stats[:speed] < bot.pokemon.stats[:speed]
      return bot
    else
      [player, bot].sample
    end
  end
    # Until one pokemon faints
    # --Print Battle Status
    # --Both players select their moves

    # --Calculate which go first and which second

    # --First attack second
    # --If second is fainted, print fainted message
    # --If second not fainted, second attack first
    # --If first is fainted, print fainted message

    # Check which player won and print messages
    # If the winner is the Player increase pokemon stats
  def battle_status(player, bot)
    puts "#{player.name.capitalize}'s #{player.pokemon.name.upcase} - Level #{player.pokemon.level}"
    puts "HP: #{player.pokemon.current_hp}"
    puts "#{bot.name}'s #{bot.pokemon.name} - Level #{bot.pokemon.level}"
    puts "HP: #{bot.pokemon.current_hp}"
  end
  
end
