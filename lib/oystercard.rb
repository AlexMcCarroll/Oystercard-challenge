class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(pound)
    @balance += pound.to_i
  end

end
