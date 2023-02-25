require_relative "constants"

module UserInput
  include Constants

  def get_input(prompt)
    puts prompt
    print "> "
    input = gets.chomp
    while input.empty?
        puts "This input shouldn't be empty"
        print "> "
        input = gets.chomp
    end
    input
  end

  def get_pokemon_name(chosen_pokemon)
    puts "You selected #{chosen_pokemon.upcase}. Great choice!"
    puts "Give your pokemon a name?"
    print "> "
    pokemon_name = gets.chomp.strip
    return chosen_pokemon.capitalize if pokemon_name.empty?
    pokemon_name
  end

  def choose_pokemon
    puts ""
    puts "1. Bulbasaur    2. Charmander   3. Squirtle"
    print "> "
    pokemon = gets.chomp.strip.downcase
    until STARTED_POKEMON.include?(pokemon)
      puts "You should choose one of the above"
      print "> "
      pokemon = gets.chomp.strip.downcase
    end
    pokemon
  end
end
