# This is the Oystercard class
class Oystercard
  attr_reader :balance, :entry_station, :journey_history
  LIMIT = 90
  FARE = 1
  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(pound)
    raise 'Sorry the new balance would exceed the limit!' if limit(pound)
    @balance += pound
  end

  def touch_in(station)
    raise 'Sorry you need to top up' if @balance < FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct_fare(FARE)
    @journey_history << { entry: @entry_station, exit: station }
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def limit(pound)
    (@balance + pound) > LIMIT
  end
  def deduct_fare(pound)
    @balance -= pound
  end
end
