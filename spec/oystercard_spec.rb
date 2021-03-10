require './lib/oystercard.rb'

describe Oystercard do
	it 'new card has a balance' do
		expect(subject).to respond_to(:balance)
	end

	it 'has a balance of 0' do
		expect(subject.balance).to eq(0)
	end

	it 'can be topped up' do
		expect(subject).to respond_to(:top_up).with(1).argument
	end

	it 'balace is changed after top up' do
		expect { subject.top_up(1) }.to change { subject.balance }.by(1)
	end

	it 'raises an error if the maximum balance is exceeded' do
		maximum_balance = Oystercard::MAXIMUM_BALANCE
		subject.top_up(maximum_balance)
		expect{ subject.top_up 1 }.to raise_error 'Maximum balance exceeded'
	end

	describe '#touch_in' do
		it 'responds to subject' do
			expect(subject).to respond_to(:touch_in).with(1).argument
		end

		it 'when user touches in, in journey changes to true' do
			subject.top_up(5)
			subject.touch_in("Waterloo")
			expect(subject).to be_in_journey
		end

		it 'an error is thrown if a card with insufficient balance is touched in' do
			expect{ subject.touch_in }.to raise_error 'Minimum balance needed'
		end
		
		it 'sets @entry_station to entry_station' do
			subject.top_up(5)
			subject.touch_in('Waterloo')
			expect(subject.entry_station).to eq 'Waterloo'
		end

		# it 'sets @entry_station to entry_station' do
		# 	max_oystercard = double(:oystercard, no_station: "Waterloo")
		# 	expect(max_oystercard.no_station).to eq "Waterloo"
		# end

	end

	describe '#touch_out' do
		before do
			subject.top_up(5)
			subject.touch_in
		end

		it 'responds to subject' do
			expect(subject).to respond_to (:touch_out)
		end

		it 'when user touches out, in journey changes to false' do
			subject.touch_out(0)
			expect(subject).not_to be_in_journey
		end

		it 'deducts money from the balance' do
			expect { subject.touch_out(3) }.to change{ subject.balance }.by -3
		end

		it 'sets @entry station to nil' do
			subject.touch_in("Waterloo")
			subject.touch_out(0)
			expect(subject.entry_station).to eq nil
		end
	end

	describe '#journeys' do
		it "has empty journeys by default" do
			expect(subject.journeys).to be_empty
		end

		it "records the entry station and exit station after touch in and touch out" do
			subject.top_up(5)
			subject.touch_in("Waterloo")
			subject.touch_out(1,"Bermondsey")
			expect(subject.journeys).to eq [{ "entry station" => "Waterloo", "exit station" => "Bermondsey" }]
		end
	end
end
