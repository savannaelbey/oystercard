class Oystercard

  MAX_CARD_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail 'balance can not be more than £90' if exceeds_limit?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end


  private

  def exceeds_limit?(amount)
    amount + @balance > MAX_CARD_LIMIT
  end

end
