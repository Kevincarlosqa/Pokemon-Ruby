require_relative "pokedex/pokemons"

class Pokemon
  include Pokedex
  attr_reader :individual_stats, :experience_points, :stats

  # (complete parameters)
  def initialize(name, species, level = 1)
    @name = name
    @level = level
    @species = species
    pokemon = Pokedex::POKEMONS.select{|_key, value| value[:species] == species.capitalize }
    @type = pokemon[species][:type]
    @base_exp = pokemon[species][:base_exp]
    @growth_rate = pokemon[species][:growth_rate]
    @base_stats = pokemon[species][:base_stats]
    @effort_points = pokemon[species][:effort_points]
    @moves = pokemon[species][:moves]
    @individual_stats = generate_individual_stats
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @experience_points = calculate_experience_points
    @stats = calculate_stats
    # Retrieve pokemon info from Pokedex and set instance variables
    # Calculate Individual Values and store them in instance variable
    # Create instance variable with effort values. All set to 0
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
  end

  def prepare_for_battle
    # Complete this
  end

  def receive_damage
    # Complete this
  end

  def set_current_move
    # Complete this
  end

  def fainted?
    # Complete this
  end

  def attack(target)
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
    Pokedex::LEVEL_TABLES[@growth_rate][@level - 1]
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

pokemon = Pokemon.new("Diego", "Bulbasaur", 2)
puts pokemon.stats

