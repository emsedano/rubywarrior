class Player
  @needs_rest = false
  @health = nil
  @@minimum_required_turns = 2
  
  def play_turn(warrior)
    # unless next cell empty
    surroundings = warrior.look

    unless warrior.feel.empty?
      # if its a enemy
      if warrior.feel.enemy?
        # evaluate if no capptives
          warrior.attack!
      elsif warrior.feel.captive?
        warrior.rescue! 
      elsif warrior.feel.wall?
        warrior.pivot!
      else        
        warrior.walk!
      end
      @needs_rest = needs_rest?(warrior)
    else 
      if !surroundings[0].captive? && (surroundings[1].enemy? || surroundings[2].enemy? ) 
        warrior.shoot! 
      # if being attacked
      elsif @health and @health > warrior.health 
        unless @needs_rest
          warrior.walk! 
        else
          warrior.walk! :backward
        end
        @needs_rest = needs_rest?(warrior)

      # if needs rest and not being attacked 
      elsif @needs_rest 
        warrior.rest!
        @needs_rest = needs_rest?(warrior)
      # else walk
      else
        warrior.walk!
      end
    end
    # set instance of current heald
    @health = warrior.health
  end

  def needs_rest?(warrior)
    # if warrior resist at least 2 turns more
    (warrior.health / 3) <= @@minimum_required_turns ? true : false
  end
  
end
