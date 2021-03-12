class Oystercard
	MAXIMUM_BALANCE = 90
	MIN_BALANCE = 1

	attr_reader :balance, :entry_station, :journeys

	def initialize(balance=0, journey = Journey.new)
		@balance = balance
		@journeys = []
		@entry_station = entry_station
		@journey = journey
		@journey_history = {}
	end

	def top_up(amount)
		@amount = amount
    @balance += amount unless max_balance_reached
	end

	def touch_in(entry_station = "unknown")
		touch_in_penalty_fare if @journey.complete_journey? == false
		@exit_station = nil
		@entry_station = entry_station unless min_balance_exceeded
		@journey.start_location(@entry_station)
	end


	def touch_out(exit_station = "unknown")
		touch_out_penalty_fare(exit_station) if @journey.complete_journey? == true
		touch_out_normal(exit_station) unless @journey.complete_journey? == true
	end

	private

	def store_journey
			@journey_history["entry station"] = @entry_station
			@journey_history["exit station"] = @exit_station
			@journeys << @journey_history
	end

	def touch_in_penalty_fare
		deduct(6)
		@journeys << @journey_history["entry station"] = @entry_station
		# could add in here
		# @journeys << @journey_history["exit station"] = "Incomplete journey"
	end

	def touch_out_penalty_fare(exit_station)
		deduct(6)
		# could add in here
		# @journeys << @journey_history["entry station"] = "Incomplete journey"
		@journeys << @journey_history["exit station"] = exit_station
	end

	def touch_out_normal(exit_station)
		deduct(@journey.calc_fare)
		@exit_station = exit_station
		store_journey
		@entry_station = nil
		@journey.end_location(@exit_station)
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
