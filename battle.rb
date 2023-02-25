require_relative "modules/constants"

class Battle
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
    puts "Fight!"
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
  end
end
