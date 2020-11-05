class Oystercard

  MINIMUM_FARE = 1
  MAX_CARD_LIMIT = 90
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Balance can not be more than #{MAX_CARD_LIMIT}" if exceeds_limit?(amount)

    @balance += amount
  end

  def touch_in(initial_station)
    fail "insufficient balance" if balance < MINIMUM_FARE

    @entry_station = initial_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !entry_station == nil?
  end


  private

  def exceeds_limit?(amount)
    amount + @balance > MAX_CARD_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
