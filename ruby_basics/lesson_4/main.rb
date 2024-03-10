require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
    attr_accessor :stations, :trains, :routes

    def initialize()
        @stations = []
        @trains = []
        @routes = []

        show_menu()
    end

    private

    CHOICES = {   
        1 => { title: 'Создать станцию', command: :create_station },
        2 => { title: 'Создать поезд', command: :create_train },
        3 => { title: 'Создать маршрут', command: :create_route },
        4 => { title: 'Добавить вагоны к поезду', command: :couple_wagons },
        5 => { title: 'Отцепить вагоны от поезда', command: :decouple_wagons },
        6 => { title: 'Добавить станцию в маршрут', command: :add_station },
        7 => { title: 'Удалить станцию из маршрута', command: :remove_station },
        8 => { title: 'Назначить маршрут поезду', command: :set_route },
        9 => { title: 'Движение по маршруту вперёд', command: :move_forward },
        10 => { title: 'Движение по маршруту назад', command: :move_backward },
        11 => { title: 'Список станций', command: :station_list },
        12 => { title: 'Список маршрутов', command: :route_list },
        13 => { title: 'Список всех поездов', command: :train_list },
        14 => { title: 'Список всех поездов с маршрутом', command: :train_list_with_routes },
        15 => { title: 'Список поездов на станции', command: :station_trains_list },
        0 => { title: 'Выход', command: :exit },
    }.freeze

    def show_menu
        loop do
            display_choice_list
            user_input = gets.chomp.to_i
            selected_choice = CHOICES[user_input]
            selected_choice.nil? ? unknown_command : run_command(selected_choice)
        end
    end

    def unknown_command
        puts 'unknown command'
    end

    def run_command(choice)
        command = choice[:command]
        send(command)
    end

    def incorrect?(value)
        if value.nil?
            puts "Некорректно указан номер"
            true
        else
            false
        end
    end

    def ask(question)
        print "#{question} "
        gets.chomp
    end

    def ask_i(question)
        print "#{question} "
        index = gets.chomp.to_i

        index - 1
    end

    def display_choice_list
        puts '==================='
        CHOICES.each do |key, value|
            title = value[:title]
            puts "#{key} - #{title}"
        end
        puts '==================='
    end

    def create_station
        station = Station.new(ask('Введите название станции:'))
        stations.push(station)
        
        puts "Создана станция #{station.name}"
    end

    def create_train
        number = ask('Введите номер поезда')
        type = ask('Введите тип поезда (cargo, passenger)')

        if type.to_sym == :passenger
            trains.push(PassengerTrain.new(number))
        elsif type.to_sym == :cargo
            trains.push(CargoTrain.new(number))
        end

        puts "Поезд создан"
    end

    def create_route
        if station_list < 2
            puts "Маршрут нельзя задать"
            return
        end

        origin_index = ask_i('Выберите из списка начальную станцию(номер)')
        origin = stations[origin_index]
        return if incorrect?(origin)

        destination_index = ask_i('Выберите из списка конечную станцию(номер)')
        destination = stations[destination_index]
        return if incorrect?(destination)

        route = Route.new(origin, destination)
        
        puts "Создан маршрут #{route_info(route)}"

        routes.push(route)
    end

    def couple_wagons
        return if train_list.zero?

        train_index = ask_i('Укажите индекс поезда для добавления вагонов:')
        train = trains[train_index]
        return if incorrect?(train)

        wagons_amount = ask('Сколько вагонов добавить?').to_i

        if train.type == :cargo
            wagons_amount.times { train.couple_wagon(CargoWagon.new) }
        else
            wagons_amount.times { train.couple_wagon(PassengerWagon.new) }
        end

        puts "Вагоны добавлены, #{train_info(train)}"
    end

    def decouple_wagons
        return if train_list.zero?

        train_index = ask_i('Укажите индекс поезда для удаления вагонов:')
        train = trains[train_index]
        return if incorrect?(train)

        wagons_amount = ask('Сколько вагонов удалить?').to_i
        wagons_amount.times { train.decouple_wagon }

        puts "Вагоны отцеплены, #{train_info(train)}"
    end

    def add_station
        return if route_list.zero?

        route_index = ask_i('Выберите номер маршрута:')
        route = routes[route_index]
        return if incorrect?(route)

        station_list
        station_index = ask_i('Укажите номер станции для добавления в маршрут:')
        station = stations[station_index]
        return if incorrect?(station)

        if route.stations.include?(station)
            puts "Станция #{station.name} уже есть в маршруте"
            return
        end

        route.add_stop(station)
        puts "Станция добавлена, теперь маршрут: #{route_info(route)}"
    end

    def remove_station
        return if route_list.zero?

        route_index = ask_i('Выберите номер маршрута:')
        route = routes[route_index]
        return if incorrect?(route)

        station_list
        station_index = ask_i('Укажите номер станции для удаления из маршрута:')
        station = stations[station_index]
        return if incorrect?(station)

        unless route.stations.include?(station)
            puts "Станции #{station.name} не было в маршруте."
            return
        end

        route.delete_stop(station)
        puts "Станция удалена, теперь маршрут: #{route_info(route)}"
    end

    def set_route
        return if route_list.zero?

        route_index = ask_i('Выберите номер маршрута:')
        route = routes[route_index]
        return if incorrect?(route)
        return if train_list.zero?

        train_index = ask_i('Укажите индекс поезда для назначения маршрута:')
        train = trains[train_index]
        return if incorrect?(train)

        train.set_route(route)

        puts "Поезду #{train.number} установлен маршрут #{route_info(route)}"
    end

    def move_forward
        return if train_list.zero?

        train_index = ask_i('Укажите индекс поезда для движения вперёд')
        train = trains[train_index]
        return if incorrect?(train)
        return if train.route.nil?
        return if incorrect?(train.current_station)

        if train.move_forward
            puts "Поезд #{train.number} уехал со станции \
        #{train.prev_station.name} и приехал на станцию #{train.current_station.name}."
        else
            puts "Поезд #{train.number} на конечной станции."
        end
    end

    def move_backward
        return if train_list.zero?

        train_index = ask_i('Укажите индекс поезда для движения вперёд')
        train = trains[train_index]
        return if incorrect?(train)
        return if train.route.nil?
        return if incorrect?(train.current_station)

        if train.move_backward
            puts "Поезд #{train.number} уехал со станции \
        #{train.prev_station.name} и приехал на станцию #{train.current_station.name}."
        else
            puts "Поезд #{train.number} на начальной станции."
        end
    end

    def station_list
        if stations.empty?
            puts 'Станций нет'
        end

        stations.each.with_index(1) do |station, index|
            puts "#{index}. Станция #{station.name}, поездов "
        end

        stations.size
    end

    def station_trains_list
        return if station_list.zero?

        station_index = ask_i('Введите номер станции, где показать поезда:')
        station = @stations[station_index]
        return if incorrect?(station)

        if station.trains.empty?
            puts "На станции #{station.name} поездов нет"
        else
            puts "На станции #{station.name} находятся поезда:"
            station.trains.each { |train| puts train_info(train) }
        end
    end

    def route_list
        if routes.empty?
            puts 'Маршрутов нет'
        end

        routes.each.with_index(1) do |route, index|
            puts "#{index}. Маршрут #{route_info(route)}"
        end

        routes.size
    end

    def route_info(route)
        return 'не задан' unless route
        route.stations.map(&:name).join("-")
    end

    def train_list
        if trains.empty?
            puts 'Поездов нет'
        else
            trains.each.with_index(1) do |train, index|
                puts "#{index}. #{train_info(train)}, маршрут #{route_info(train.route)}"
            end
        end

        trains.size
    end

    def train_list_with_routes
        trains_with_routes = @trains.select(&:current_station)

        if trains_with_routes.empty?
            puts 'Поездов с маршрутом нет'
        else
            trains_with_routes.each.with_index(1) do |train, index|
                puts "#{index}. #{train_info(train)}, маршрут #{route_info(train.route)}"
            end
        end

        trains_with_routes.size
    end

    def train_info(train)
        "поезд  #{train.number}, тип: #{train.type}, вагонов: #{train.wagons.size}"
    end

    def exit
        abort
    end
end

Main.new