# This is the Oystercard class
class Oystercard
  attr_reader :balance, :limit

  def initialize
    @balance = 0
    @limit = 90
  end

  def top_up(pound)
    raise 'Sorry the new balance would exceed the limit!' if (@balance + pound) > @limit
    @balance += pound
  end

  def deduct(pound)
    @balance -= pound
  end
end
