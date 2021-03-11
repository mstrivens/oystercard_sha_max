require 'journey'

describe Journey do
  describe '#start_location' do
    it 'responds to journey' do
      expect(subject).to respond_to(:start_location)
    end
    it 'takes a entry_station from touch_in'
  end
end
