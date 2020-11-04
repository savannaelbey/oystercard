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

end
