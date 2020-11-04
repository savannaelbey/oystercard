class Oystercard

  MINIMUM_FARE = 1
  MAX_CARD_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance can not be more than #{MAX_CARD_LIMIT}" if exceeds_limit?(amount)

    @balance += amount
  end

  def touch_in
    fail "insufficient balance" if balance < MINIMUM_FARE

    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false

  end

  def in_journey?
    @in_journey
  end


  private

  def exceeds_limit?(amount)
    amount + @balance > MAX_CARD_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
