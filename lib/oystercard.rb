class Oystercard
	MAXIMUM_BALANCE = 90
	MIN_BALANCE = 1

	attr_reader :balance, :entry_station, :journeys

	def initialize(balance=1,journey = Journey.new)
		@balance = balance
		@journeys = []
		@entry_station = entry_station
		@journey = journey
	end

	def top_up(amount)
		@amount = amount
    @balance += amount unless max_balance_reached
	end

	def touch_in(entry_station = "unknown")
		deduct(6) if @journey.in_journey? == true
		@entry_station = entry_station unless min_balance_exceeded
		store_journey
		journey = Journey.new
		@journey.start_location(@entry_station)
		# @journey = {}
		# @journey["entry station"] = entry_station
	end


	def touch_out(exit_station = "unknown")
		if @journey.in_journey? == false
			deduct(6)
		else
			deduct(@journey.calc_fare)
		end
		@entry_station = nil
		@exit_station = exit_station
		store_journey #@journey["exit station"] = exit_station
		@journey.end_location(@exit_station)
	end

	private

	def store_journey
			@journey_history = {}
			if @entry_station == nil
				@journey_history["exit station"] = @exit_station
			elsif @exit_station == nil
				@journey_history["entry station"] = @entry_station
			else
				@journey_history["exit station"] = @exit_station
				@journey_history["entry station"] = @entry_station
			end
			@journeys << @journey_history
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
