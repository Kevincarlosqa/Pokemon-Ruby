require_relative "modules/constants"
require_relative "pokedex/moves"

class Battle
  include Pokedex
  include Constants
  
  def initialize(player, bot)
    @player = player
    @bot = bot
    @winning = nil
  end

  def start
    @player.pokemon.prepare_for_battle
    @bot.pokemon.prepare_for_battle
    if @bot.instance_of? Leader
      puts "#{@player.name} challenge the Gym Leader Brock for a fight!"
    else
      puts "#{@player.name} challenge #{@bot.name} for training"
    end
    puts "#{@bot.name} has a #{@bot.pokemon.name} level #{@bot.pokemon.level}"
    puts "What do you want to do now?"
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
    puts "\n-------------------Battle Start!-------------------\n\n"
    until @player.pokemon.fainted? || @bot.pokemon.fainted?
      battle_status(@player,@bot)
      puts "\n#{@player.name}, select your move:\n\n"
      @player.select_move
      @bot.select_move
      puts "\n--------------------------------------------------"
      first_attacker = turn_order(@player,@bot)
      second_attacker = first_attacker == @player ? @bot : @player
      first_attacker.pokemon.attack(second_attacker.pokemon)
      second_attacker.pokemon.attack(first_attacker.pokemon) unless second_attacker.pokemon.fainted?
      puts ""
    end

    winner = @player.pokemon.fainted? ? @bot : @player
    loser = winner == @player ? @bot : @player

    puts ""
    puts "**************************************************"
    puts "#{loser.pokemon.name} FAINTED!"
    puts "#{winner.pokemon.name} WINS!!"
    puts "-------------------Battle Ended!-------------------"
    puts "**************************************************"
    puts ""
    puts ""

    if winner == @player
      gain_exp = (@bot.pokemon.base_exp * @bot.pokemon.level / 7.0).floor
      @player.pokemon.increase_stats(@bot.pokemon, gain_exp)
      if @bot.instance_of? Leader
        puts "Congratulation! You have won the game!"
        puts "You can continue training your Pokemon if you want"
      end
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
    
  def battle_status(player, bot)
    puts "#{player.name.capitalize}'s #{player.pokemon.name.upcase} - Level #{player.pokemon.level}"
    puts "HP: #{player.pokemon.current_hp}"
    puts "#{bot.name}'s #{bot.pokemon.name} - Level #{bot.pokemon.level}"
    puts "HP: #{bot.pokemon.current_hp}"
  end
end
