require 'journeylog'
require 'oystercard'
require 'journey'

describe JourneyLog do
  describe '#start' do
    it 'responds to JourneyLog' do
      expect(subject).to respond_to(:start).with(1).argument
    end
  end
    it 'is equal to journey start station' do
      # journey_double = double(:journey, start_location: "Waterloo")
      # journeylog = JourneyLog.new(journey_double)
        expect(subject.start("Waterloo"))
    end
#
#     it 'returns journey start station to eq touch_in station' do
#       journey_double = double(:journey, in_journey?: true)
#       journey = Journey.new
#       journey.start("Waterloo")
#
#         expect(subject.start("Waterloo")).to eq "Waterloo"
#     end

    describe '#finish' do
      it 'responds to JourneyLog' do
        expect(subject).to respond_to(:finish).with(1).argument
      end
    end
      it 'is equal to journey end station' do
        # journey_double = double(:journey, end_location: "Euston")
        # journeylog = JourneyLog.new(journey_double)
          expect(subject.finish("Euston"))
      end


#
end
