# This is the station class
class Station

  attr_reader :name, :zone

  def initialize(station_info)
    @name = station_info[:name]
    @zone = station_info[:zone]

  end
end
