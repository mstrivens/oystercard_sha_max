require 'station'

describe Station do
    describe '#initialize' do
        station = Station.new("Waterloo", 1) 
        it 'sets a value for name' do
            expect(station.name).to eq "Waterloo"
        end
        it 'sets a value for zone' do
            expect(station.zone).to eq 1
        end
    end
end