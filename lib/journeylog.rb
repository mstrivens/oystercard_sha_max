class JourneyLog

  attr_reader :journeys

  def initialize(journey = Journey.new)
    @journeys = journey
    @journey_history = []
  end

  def start(start_station)
    @journey_history << @journeys.start_location(start_station)
  end

  def finish(end_station)
    @journey_history << @journeys.end_location(end_station)

  end


  def completed_journey?
    @journey_history.last.completed_journey?
  end

  private

  def current_journey
    @journeys.current_journey
  end
end
