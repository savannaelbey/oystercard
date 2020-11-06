require 'oystercard'

describe Oystercard do
  let(:entry_station) { double('station_double') }
  let(:exit_station) { double('station_double') }
  let(:journey) {{entry: entry_station, exit: exit_station}}

  describe '#initialize' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq 0
    end
    it ' creates an empty list of journeys on instantiation' do
      expect(subject.journey_history).to eq []
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
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    it 'tells us we are not in a journey after we have touched out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it 'will not touch in if balance is below minimum amount' do
      expect { subject.touch_in(entry_station) }.to raise_error "insufficient balance"
    end
    it 'will remember the entry station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect(subject.entry_station). to eq entry_station
    end
  end

  describe '#touch_out' do
    it "accepts an argument" do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end
    it "charges the card £#{Oystercard::MINIMUM_FARE} on touch out" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end
    it "makes the card forget the entry station" do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end
    it 'saves exit station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
    it 'it adds entry and exit stations to journey history' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include(journey)
    end
  end

end
