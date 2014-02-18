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
          change_direction(@@direction)
          warrior.walk! @@direction
        end
      elsif warrior.feel(@@direction).captive?
        @@captives = @@captives - 1
        warrior.rescue! @@direction     
      elsif warrior.feel(@@direction).wall?
        change_direction(@@direction)
        warrior.walk! @@direction
      else
        change_direction(@@direction, :forward) if @@captives <= 0
        warrior.walk! @@direction
      end
      @needs_rest = needs_rest?(warrior)
    else
      if @health and @health > warrior.health 
        if warrior.health >= @@minimum_required_health
          change_direction(@@direction, :forward)
          warrior.walk! @@direction
        else
          change_direction(@@direction, :backward)
          warrior.walk! @@direction
        end
      elsif @needs_rest and warrior.feel.empty?
        warrior.rest!
        @needs_rest = needs_rest?(warrior)
      elsif warrior.feel(@@direction).wall?
        
        change_direction(@@direction, :backward)
        warrior.walk! @@direction
      else
        if @@captives <= 0
          change_direction(@@direction, :forward) 
        else
          change_direction(@@direction, :backward)
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

  def change_direction(direction, towards=nil)
    if !towards
      @@direction = direction == :forward ? :backward : :forward
    else
      @@direction = towards
    end

  end

  
end
