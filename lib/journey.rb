class Journey
attr_reader :end_location, :start_location, :current_journey
  def initialize
    @current_journey = { "entry station" => nil, "exit station" => nil }
  end

  def start_location(entry_station)
    @current_journey["entry station"] = entry_station
  end

  def end_location(exit_station)
    @current_journey["exit station"] = exit_station
  end

	def complete_journey?
		!@current_journey.has_value?(nil)
	end

  def calc_fare
    Oystercard::MIN_BALANCE
  end

  # def current_journey
  #
  # end
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
