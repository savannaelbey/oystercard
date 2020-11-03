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
  end


end
