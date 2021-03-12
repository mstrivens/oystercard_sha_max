class JourneyLog
  attr_reader :journey_start
  def initialize(journey = Journey.new)
    @journey = journey
    @journey_history = {}
  end
  def start(start_station)
    @journey_start = @journey.start_location(start_station)
  end
end
