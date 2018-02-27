# This is the Oystercard class
class Oystercard
  attr_reader :balance, :limit, :in_station
  ZERO = 0
  ONE = 1
  LIMIT = 90
  FARE = 1
  def initialize(balance = ZERO, limit = LIMIT)
    @balance = balance
    @limit = limit
    @in_station = false
  end

  def top_up(pound)
    raise 'Sorry the new balance would exceed the limit!' if limit(pound)
    @balance += pound
  end

  def touch_in
    raise 'Sorry you need to top up' if minimal
    @in_station = true
  end

  def touch_out
    deduct_fare(FARE)
    @in_station = false
  end

  def in_journey?
    @in_station
  end

  private

  def minimal
    @balance < ONE
  end

  def limit(pound)
    (@balance + pound) > LIMIT
  end
  def deduct_fare(pound)
    @balance -= pound
  end
end
