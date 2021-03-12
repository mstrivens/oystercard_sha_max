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

  # describe '#in_journey' do
  #   it 'knows it\'s in a journey' do
  #     subject.start_location("Euston")
  #     expect(subject).to be_in_journey
  #   end
  # end

  describe '#current_journey' do
    it "records the entry station and exit station after touch in and touch out" do
      subject.start_location("Waterloo")
      subject.end_location("Bermondsey")
      expect(subject.current_journey).to eq ({ "entry station" => "Waterloo", "exit station" => "Bermondsey" })
    end
  end

  describe '#complete_journey' do
    it  'knows if journey is completed or not' do
    expect(subject.complete_journey?).to eq false
    end
  end

  describe '#complete_journey' do
    it  'knows if journey is completed or not' do
      subject.start_location("Waterloo")
      subject.end_location("Bermondsey")
        expect(subject.complete_journey?).to eq true
    end
  end
end
