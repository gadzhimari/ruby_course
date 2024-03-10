class Route
    attr_reader :origin, :destination, :stops

    def initialize(origin, destination)
        @origin = origin
        @destination = destination
        @stops = []
    end

    def add_stop(stop)
        @stops.push(stop)
    end
    
    def delete_stop(stop)
        @stops.delete(stop)
    end

    def stations
        [@origin, @stops, @destination].flatten.compact
    end
end