class Train
    attr_reader :speed, :type, :carriages

    def initialize(number, type, carriages)
        @number = number
        @type = type
        @carriages = carriages
        @speed = 0
        @route = nil
        @station_number = nil
    end

    def set_route(route)
        @route = route
        @station_number = 0
        current_station.arrive_train(self)
    end

    def current_station
        @route.stations[@station_number]
    end
    
    def next_station
        return unless @route
        @route.stations[@station_number + 1]
    end

    def prev_station
        return unless @route
        return if @station_number < 1
        @route.stations[@station_number - 1]
    end
    
    def move_forward
        return unless @route && next_station
    
        current_station.depart_train(self)
        @station_number += 1
        current_station.arrive_train(self)
    end
    
    def move_backward
        return unless @route && previous_station
    
        current_station.depart_train(self)
        @station_number -= 1
        current_station.arrive_train(self)
    end

    def couple_carriage
        @carriages += 1 if moving?
    end
    
    def decouple_carriage
        return if moving?
            @carriages == 0 ? 0 : @carriages -= 1
    end

    def moving?
        self.speed != 0
    end

    def speed_up
        @speed += 10 
    end

    def stop
        @speed = 0
    end
end