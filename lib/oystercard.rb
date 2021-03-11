class Oystercard
	MAXIMUM_BALANCE = 90
	MIN_BALANCE = 1

	attr_reader :balance, :entry_station, :journeys

	def initialize(journey = Journey.new, balance=1)
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
		@entry_station = entry_station unless min_balance_exceeded
		store_journey
		journey = Journey.new
		@journey.start_location(@entry_station)
		# @journey = {}
		# @journey["entry station"] = entry_station
	end

	def in_journey?
		@entry_station != nil
	end

	def touch_out(amount, exit_station = "unknown")
		deduct(amount)
		@entry_station = nil
		@exit_station = exit_station
		store_journey #@journey["exit station"] = exit_station
	end

	private

	def store_journey
		if @entry_station
			@journey_history = {}
			@journey_history["entry station"] = @entry_station
		else
			@journey_history["exit station"] = @exit_station
			@journeys << @journey_history
		end
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
