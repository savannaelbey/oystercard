require 'oystercard'

describe Oystercard do
  let(:station){ double :station_double }

  describe '#initialize' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up()' do
    it 'Adds money to balance' do
      expect(subject.top_up(10)).to eq 10
    end

    it "raises error if top_up amount + balance is > than #{Oystercard::MAX_CARD_LIMIT}" do
      subject.top_up(10)
      expect { subject.top_up(Oystercard::MAX_CARD_LIMIT) }.to raise_error "Balance can not be more than #{Oystercard::MAX_CARD_LIMIT}"
    end
  end

  describe '#in_journey?' do
    it 'tells us if we are not in a journey' do
      expect(subject).to_not be_in_journey
    end
    it 'tells us we are in a journey' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it 'tells us we are not in a journey after we have touched out' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it 'will not touch in if balance is below minimum amount' do
      expect { subject.touch_in(station) }.to raise_error "insufficient balance"
    end
    it 'will remember the entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station). to eq station
    end
  end

  describe '#touch_out' do
    it "charges the card £#{Oystercard::MINIMUM_FARE} on touch out" do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end
    it 'makes the card forget the entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end





end
