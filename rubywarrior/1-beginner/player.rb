class Player
  @needs_rest = false
  @health = nil
  @@minimum_required_health = 14
  @@captives = 0
  @@direction = :forward
  def play_turn(warrior)
    # unless next cell empty
    being_attacked = false
    unless warrior.feel.empty?
      
      # if its a enemy
      if warrior.feel.enemy?
        # evaluate if no capptives
        if !hear_captives? #and !@needs_rest # no captives
          warrior.attack!
        else #lets rescue
          warrior.walk! :backward
        end
      
      elsif warrior.feel.captive?
        @@captives = @@captives - 1
        warrior.rescue! 
      
      elsif warrior.feel.wall?
        warrior.pivot!
      else
        lets_do_it if !hear_captives?
        warrior.walk! 
      end
      @needs_rest = needs_rest?(warrior)
    else 
      # if being attacked
      if @health and @health > warrior.health 
        being_attacked = true
        unless @needs_rest
          warrior.walk! 
        else
          warrior.walk! :backward
        end
        @needs_rest = needs_rest?(warrior)
      elsif @needs_rest # if needs rest and not being attacked
        
        warrior.rest!
        
        @needs_rest = needs_rest?(warrior)
      else
        if hear_captives?
          warrior.pivot
        else
          warrior.walk!
        end 
        
      end
    end
    # set instance of current heald
    @health = warrior.health
  end

  def needs_rest?(warrior)
    # if warrior resist at least 2 turns more
    (warrior.health / 3) <= 2 ? true : false
  end

  def switch_direction
    @@direction = @@direction == :forward ? :backward : :forward
  end

  def lets_do_it
    @@direction = :forward
  end

  def oh_fuck
    @@direction = :backward
  end

  def hear_captives?
    @@captives > 0
  end

  
end
