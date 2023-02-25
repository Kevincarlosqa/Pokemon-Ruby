require_relative "pokedex/pokemons"
require_relative "pokedex/moves"
require_relative "modules/constants"

class Pokemon
  include Pokedex
  include Constants
  attr_reader :name, :species, :individual_stats, :level,
              :experience_points, :stats, :moves, :type
  attr_accessor :current_move, :current_hp
              

  def initialize(name, species, level = 1)
    @name = name
    @level = level
    @species = species.capitalize
    @current_move = nil
    pokemon = POKEMONS.select{|_key, value| value[:species] == @species }
    @type = pokemon[@species][:type]
    @base_exp = pokemon[@species][:base_exp]
    @growth_rate = pokemon[@species][:growth_rate]
    @base_stats = pokemon[@species][:base_stats]
    @effort_points = pokemon[@species][:effort_points]
    @moves = pokemon[@species][:moves]
    @individual_stats = generate_individual_stats
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @experience_points = calculate_experience_points
    @stats = calculate_stats
    @current_hp = nil
  end

  def prepare_for_battle
    @current_hp = @stats[:hp]
  end

  def receive_damage
    # Complete this
  end

  # def set_current_move(move)
  #   @current_move = move
  # end

  def fainted?
    !@current_hp.positive?
  end

  def attack(target)
    puts "#{@name} used #{@current_move.upcase}!"
    hit = MOVES[current_move][:accuracy] >= rand(1..100)
    unless hit
      puts "#{@name} missed the attack to #{target.name}"
      return
    end
    critical_hit = 1 == rand(1..16)
    offensive_stat = SPECIAL_ATTACKS.include?(MOVES[@current_move][:type]) ? @stats[:special_attack] : @stats[:attack]
    target_defensive_stat = SPECIAL_ATTACKS.include?(MOVES[target.current_move][:type]) ? target.stats[:special_defense] : target.stats[:defense]
    move_power = MOVES[@current_move][:power]
    damage = (((2 * @level / 5.0 + 2).floor * offensive_stat * move_power / target_defensive_stat).floor / 50.0).floor + 2
    if critical_hit
      damage *= 1.5 
      puts "It was CRITICAL hit!"
    end
    type_effectiveness = calculate_effectiveness(MOVES[@current_move][:type], MOVES[target.current_move][:type])
    damage = (damage * type_effectiveness).floor
    target.current_hp -= damage
    puts "It's not very effective..." if type_effectiveness <= 0.5
    puts "It's super effective!" if type_effectiveness >= 1.5
    puts "It doesn't affect #{target.name}!" if type_effectiveness == 0
    puts "And it hit #{target.name} with #{damage} damage"
    puts "--------------------------------------------------"
   
    # Print attack message 'Tortuguita used MOVE!'
    # Accuracy check
    # If the movement is not missed
    # -- Calculate base damage
    # -- Critical Hit check
    # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
    # -- Effectiveness check
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message if neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    # Else, print "But it MISSED!"
  end

  def calculate_effectiveness(attacker_type, target_type)
    effectivenes = 1
    TYPE_MULTIPLIER.each do |hash|
      if hash[:user] == attacker_type && hash[:target] == target_type
        effectivenes = hash[:multiplier]
      end
    end
    effectivenes
  end

  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"

    # If the new experience point are enough to level up, do it and print
    # message "#[pokemon name] reached level [level]!" # -- Re-calculate the stat
  end

  private

  def generate_individual_stats
    { 
      hp: rand(0..31),
      attack: rand(0..31), 
      defense: rand(0..31), 
      special_attack: rand(0..31), 
      special_defense: rand(0..31),
      speed: rand(0..31)
    }
  end

  def calculate_experience_points
    return 0 if @level == 1
    LEVEL_TABLES[@growth_rate][@level - 1]
  end

  def calculate_stats
    hp = calculate_hp(@base_stats[:hp], @individual_stats[:hp], @effort_values[:hp], @level)
    attack = calculate_others_stats(@base_stats[:attack], @individual_stats[:attack], @effort_values[:attack], @level)
    defense = calculate_others_stats(@base_stats[:defense], @individual_stats[:defense], @effort_values[:defense], @level)
    special_attack = calculate_others_stats(@base_stats[:special_attack], @individual_stats[:special_attack], @effort_values[:special_attack], @level)
    special_defense = calculate_others_stats(@base_stats[:special_defense], @individual_stats[:special_defense], @effort_values[:special_defense], @level)
    speed = calculate_others_stats(@base_stats[:speed], @individual_stats[:speed], @effort_values[:speed], @level)
    { 
      hp: , 
      attack: , 
      defense: , 
      special_attack: , 
      special_defense: , 
      speed:  
    }
  end

  def calculate_hp(base_stat, stat_individual_value, stat_effort, level)
    ((2 * base_stat + stat_individual_value + stat_effort) * level / 100 + level + 10).floor
  end 

  def calculate_others_stats(base_stat, stat_individual_value, stat_effort, level)
    ((2 * base_stat + stat_individual_value + stat_effort) * level / 100 + 5).floor
  end 
end

# pokemon = Pokemon.new("Diego", "Bulbasaur", 2)
# puts pokemon.stats
