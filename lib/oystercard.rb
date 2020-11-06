class Oystercard

  MINIMUM_FARE = 1
  MAX_CARD_LIMIT = 90
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Balance can not be more than #{MAX_CARD_LIMIT}" if exceeds_limit?(amount)

    @balance += amount
  end

  def touch_in(station)
    fail "insufficient balance" if insufficient_balance?

    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    add_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def insufficient_balance?
    balance < MINIMUM_FARE
  end

  def exceeds_limit?(amount)
    amount + @balance > MAX_CARD_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

  def add_journey
    journey_history << {entry: @entry_station, exit: @exit_station}
  end

end
