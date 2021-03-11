require 'journey'

describe Journey do
  describe '#start_location' do
    it 'responds to journey' do
      expect(subject).to respond_to(:start_location)
    end
    it 'sets an entry station' do
      # station_double = double(:oystercard, entry_station: "Waterloo")
      expect(subject.start_location("Waterloo")).to eq "Waterloo"
    end

  end
  describe '#end_location' do
    it 'responds to journey' do
      expect(subject).to respond_to(:end_location)
    end
    it 'takes an exit station from touch in' do
      expect(subject.end_location("Euston")).to eq "Euston"
    end
  end

  describe '#in_journey' do
    it 'knows it\'s in a journey' do
      subject.start_location("Euston")
      expect(subject).to be_in_journey
    end
  end
end
