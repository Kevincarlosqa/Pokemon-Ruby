require_relative "pokemon"

class Player
  attr_reader :name, :species, :pokemon 
  attr_accessor :fainted
  def initialize(name, species, pokemon_name = nil, pokemon_level = 1)
    @name = name
    @pokemon = Pokemon.new(pokemon_name, species, 3)
  end

  def select_move
    @pokemon.moves.each.with_index do |move, index|
  
    print "#{index+1}. #{move}      "
    end
    puts "\n"
    print "> "
    input = gets.chomp.downcase
    unless @pokemon.moves.include?(input)
      print "> "
      input = gets.chomp.downcase
    end
    @pokemon.current_move = input
  end
end

class Bot < Player
  attr_reader :species, :pokemon
  def initialize
    @name = "Random Person"
    @species = Pokedex::POKEMONS.keys.sample
    @pokemon = Pokemon.new(@species, @species, 1)

  end
  def select_move
    @pokemon.current_move = @pokemon.moves.sample
  end
end

class Leader < Player
  attr_reader :species, :pokemon
  def initialize
    @name = "Brook"
    @species = "Onix"
    @pokemon = Pokemon.new(@species, @species, 10)

  end
  def select_move
    @pokemon.current_move = @pokemon.moves.sample
  end
end

# ne = Leader.new
#  p ne.class
# #  p ne.pokemon
# puts ne.instance_of? Leader
# bu = Bot.new
# p bu.species
# p bu.pokemon
