class Oystercard
	MAXIMUM_BALANCE = 90
	MIN_BALANCE = 1

	attr_reader :balance, :entry_station, :journeys

	def initialize
		@balance = 0
		@journeys = []
	end

	def top_up(amount)
		@amount = amount
    	@balance += amount unless max_balance_reached
	end

	def touch_in(entry_station = "unknown")
		@entry_station = entry_station unless min_balance_exceeded
		store_journey
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
			@journey = {}
			@journey["entry station"] = @entry_station
		else
			@journey["exit station"] = @exit_station
			@journeys <<  
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
