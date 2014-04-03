class Player
  @@directions = [:forward, :left, :right, :backward]
  @@minimum_required_turns = 4
  
  def play_turn(warrior)
    # add your code here
    if warrior.feel(:forward).enemy?
      warrior.attack! :forward
    elsif warrior.feel(:left).enemy?
      warrior.attack! :left
    elsif warrior.feel(:right).enemy?
      warrior.attack! :right
    elsif warrior.feel(:backward).enemy?
      warrior.attack! :backward
    else
      if needs_rest?(warrior)
        warrior.rest!
      else
        warrior.walk! warrior.direction_of_stairs
      end
    end
  end

   def needs_rest?(warrior)
    # if warrior resist at least 2 turns more
    (warrior.health / 3) <= @@minimum_required_turns ? true : false
  end
end
