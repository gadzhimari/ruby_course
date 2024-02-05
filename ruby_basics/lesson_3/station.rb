class Station
    attr_reader :name, :trains
    
    def initialize(name)
        @name = name
        @trains = []
    end

    def arrive_train(train)
        @trains << train
    end

    def depart_train(train)
        @trains.delete(train)
    end

    def get_trains_by_type(type)
        @trains.select { |train| train.type == type }
    end
end