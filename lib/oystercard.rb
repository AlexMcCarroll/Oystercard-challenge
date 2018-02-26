class Oystercard

  attr_reader :balance , :limit

  def initialize
    @balance = 0
    @limit = 90
  end

  def top_up(pound)
    fail 'Sorry the new balance would exceed the limit!' if (@balance + pound.to_i) > @limit
    @balance += pound.to_i
  end

end
