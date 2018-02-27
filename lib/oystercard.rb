# This is the Oystercard class
class Oystercard
  attr_reader :balance, :limit, :in_station
  ZERO = 0
  ONE = 1
  LIMIT = 90
  def initialize(balance = ZERO, limit = LIMIT)
    @balance = balance
    @limit = limit
    @in_station = false
  end

  def top_up(pound)
    raise 'Sorry the new balance would exceed the limit!' if (@balance + pound) > @limit
    @balance += pound
  end

  def deduct(pound)
    @balance -= pound
  end

  def touch_in
    raise 'Sorry you need to top up' if @balance < ONE
    @in_station = true
  end

  def touch_out
    @in_station = false
  end

  def in_journey?
    @in_station
  end
end
