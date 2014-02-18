class Player
  @needs_rest = false
  @health = nil
  @@minimum_required_health = 17
  @@captives = 1
  @@direction = :forward
  def play_turn(warrior)
    # add your code here
    unless warrior.feel(@@direction).empty?
      if warrior.feel(@@direction).enemy?
        if @@captives <= 0
          warrior.attack! 
        else #lets rescue
          switch_direction
          warrior.walk! @@direction
        end
      elsif warrior.feel(@@direction).captive?
        @@captives = @@captives - 1
        warrior.rescue! @@direction     
      elsif warrior.feel(@@direction).wall?
        switch_direction
        warrior.walk! @@direction
      else
        switch_direction if @@captives <= 0
        warrior.walk! @@direction
      end
      @needs_rest = needs_rest?(warrior)
    else
      if @health and @health > warrior.health 
        if warrior.health >= @@minimum_required_health
          lets_do_it
          warrior.walk! @@direction
        else
          oh_fuck
          warrior.walk! @@direction
        end
      elsif @needs_rest and warrior.feel.empty?
        warrior.rest!
        @needs_rest = needs_rest?(warrior)
      elsif warrior.feel(@@direction).wall?
        
        oh_fuck
        warrior.walk! @@direction
      else
        if @@captives <= 0
          lets_do_it
        else
          oh_fuck
        end 
        warrior.walk! @@direction
      end
    end
    
    # set instance of current heald
    @health = warrior.health
  end

  def needs_rest?(warrior)
    warrior.health <= @@minimum_required_health ? true : false
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

  
end
