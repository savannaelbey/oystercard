require 'station'

describe Station do
  let(:station) {Station.new("Piccadily", 1)}
  describe '#initialize' do
    it 'has a name on instantiation' do
      expect(station.name).to eq "Piccadily"
    end
    it 'has a zone on initialisation' do
      expect(station.zone).to eq 1
    end
  end
end
