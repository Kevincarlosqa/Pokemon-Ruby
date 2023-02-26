module InitialMessages
  def welcome_message
    message = <<~DELIMETER
      #$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#
      #$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
      #$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#
      #$#$#$#$#$#$#$                               $#$#$#$#$#$#$#
      #$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#

      Hello there! Welcome to the world of POKEMON! My name is OAK!
      People call me the POKEMON PROF!

      This world is inhabited by creatures called POKEMON! For some
      people, POKEMON are pets. Others use them for fights. Myself...
      I study POKEMON as a profession.
    DELIMETER
    puts message
  end

  def welcome_player(name)
    message = <<~DELIMETER
      \nRight! So your name is #{name.upcase}!
      Your very own POKEMON legend is about to unfold! A world of
      dreams and adventures with POKEMON awaits! Let's go!
      Here, #{name.upcase}! There are 3 POKEMON here! Haha!
      When I was young, I was a serious POKEMON trainer.
      In my old age, I have only 3 left, but you can have one! Choose!
    DELIMETER
    puts message
  end

  def final_message(name, chosen_pokemon_name)
    message = <<~DELIMETER
      \n#{name.upcase}, raise your young #{chosen_pokemon_name.upcase} by making it fight!
      When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER
    DELIMETER
    puts message
  end
end
