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

	it 'responds to deduct method with an argument' do
		expect(subject).to respond_to(:deduct).with(1).argument
  	end


	it 'deducts an amount from the balance' do
    	subject.top_up(20)
    	expect{ subject.deduct(3)}.to change{ subject.balance }.by -3
  end

	describe '#touch_in' do
		it 'responds to subject' do
			expect(subject).to respond_to (:touch_in)
		end

		it 'when user touches in, in journey changes to true' do
			subject.top_up(5)
			subject.touch_in
			expect(subject).to be_in_journey
		end

		it 'an error is thrown if a card with insufficient balance is touched in' do
			expect{ subject.touch_in }.to raise_error 'Minimum balance needed'
		end
	end

	describe '#touch_out' do
		it 'responds to subject' do
			expect(subject).to respond_to (:touch_out)
		end

		it 'when user touches out, in journey changes to false' do
			subject.top_up(5)
			subject.touch_in
			subject.touch_out
			expect(subject).not_to be_in_journey
		end
	end
end
