require 'journey'

describe Journey do
  describe '#start_location' do
    it 'responds to journey' do
      expect(subject).to respond_to(:start_location)
    end
    it 'takes a entry_station from touch_in' do
      # station_double = double(:oystercard, entry_station: "Waterloo")
      card = Oystercard.new#(station_double)
      card.top_up(10)
      card.touch_in("Waterloo")
      expect(subject.start_location("Waterloo")).to eq "Waterloo"
    end
  end
end
