class Journey
attr_reader :end_location, :start_location
  def initialize
  end
  def start_location(entry_station)
    @start_location = entry_station
  end

  def end_location(exit_station)
    @end_location = exit_station
  end

	def in_journey?
		@start_location != nil
	end

  def calc_fare
    Oystercard::MIN_BALANCE
  end
end
# def initialize(start_station)
#     @start_station = start_station
# end

# def incomplete_journey
#     sleep(2*60*60)
#     break if @exit_station
#     time + (2.0)
#     exit_station = special
#     entry_station = nil
# end

# private

# def time
#     time = Time.new
# end
