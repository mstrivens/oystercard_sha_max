class Oystercard
	MAXIMUM_BALANCE = 90
	MIN_BALANCE = 1

	attr_reader :balance, :entry_station, :journeys, :journey

	def initialize(balance=0)
		@balance = balance
		@journeys = []
		@journey = Journey.new
		@journey_history = JourneyLog.new
	end

	def top_up(amount)
		@amount = amount
    @balance += amount unless max_balance_reached
	end

	def touch_in(entry_station = "unknown")
		touch_in_penalty_fare if @journey.completed_journey == false
		@journey.start_location(entry_station) unless min_balance_exceeded
		@journey.start_location(entry_station)
	end


	def touch_out(exit_station = "unknown")
		touch_out_penalty_fare(exit_station) if @journey.completed_journey == true
		touch_out_normal(exit_station) unless @journey.completed_journey == true
	end

	private

	def store_journey
			@journeys << @journey.current_journey
	end

	def touch_in_penalty_fare
		deduct(6)
		@journeys << store_journey
	end

	def touch_out_penalty_fare(exit_station)
		deduct(6)
		@journeys << store_journey
	end

	def touch_out_normal(exit_station)
		deduct(@journey.calc_fare)
		store_journey
		@journey.end_location(exit_station)
	end

	def max_balance_reached
		fail 'Maximum balance exceeded' if @amount + @balance > MAXIMUM_BALANCE
	end

	def min_balance_exceeded
		fail 'Minimum balance needed' if @balance < MIN_BALANCE
	end

	def deduct(deduct_amount)
		@balance -= deduct_amount
	end
end
