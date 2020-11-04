require 'oystercard'

describe Oystercard do

  describe '#initialize' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up()' do
    it 'Adds money to balance' do
      expect(subject.top_up(10)).to eq 10
    end

    it 'raises error if top_up amount + balance is > than £90' do
      expect { subject.top_up(91) }.to raise_error 'balance can not be more than £90'
    end
  end

  describe '#deduct()' do
    it 'deducts money from card' do
      expect{ subject.deduct(10) }.to change{subject.balance}.by -10
    end
  end

  #describe '#touch_in' do
    #it 'tells us the card is being used on journey' do
      #expect{ subject.touch_in }.to change{subject.in_journey?}.to true
    #end
  #end

  describe '#in_journey?' do
    it 'tells us if we are not in a journey' do
      expect(subject).to_not be_in_journey
    end
    it 'tells us we are in a journey' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it 'tells us we are not in a journey after we have touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end



end
