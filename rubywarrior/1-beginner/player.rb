class Player
  @needs_rest = false
  @health = nil
  def play_turn(warrior)
    # add your code here
    unless warrior.feel.empty?
      if warrior.feel.enemy?      
        warrior.attack! 
      elsif warrior.feel.captive?
        warrior.rescue!     
      end
      @needs_rest = needs_rest?(warrior)
    else
      if @health and @health > warrior.health 
        warrior.walk!
      elsif @needs_rest and warrior.feel.empty?
        warrior.rest!
        @needs_rest = needs_rest?(warrior)
      else
        warrior.walk!
      end
    end 
    # set instance of current heald
    @health = warrior.health
  end

  def needs_rest?(warrior)
    puts "health #{warrior.health} <= 7 : #{warrior.health <= 7 }"
    warrior.health <= 18 ? true : false
  end
  
end
