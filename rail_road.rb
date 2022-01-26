require "./station"
require "./route"
require "./passenger_train"
require "./cargo_train"
require "./train"
require "./car"
require "./cargo_car"
require "./passenger_car"

# класс ЖелезнаяДорога
class RailRoad
  attr_accessor :stations, :route, :trains
  # при содании никакие параметры не передаем
  # у железной дороги есть
  #  - список станций (по умолчанию пустой)
  #  - список маршрутов (по умолчанию пустой)
  #  - список поездов (по умолчанию пустой)

  def manage_rail_road
    puts "Управление железной дорогой"
    loop do
    puts "------------------"
    puts "Выберите действие:"
    puts ACTIONS
    action = gets.chomp.to_i
    case action
    when 0
      break # выходим из цикла "loop do"
    when 1 # stations
      puts "Выберите действие со станциями:"
      puts STATIONS_ACTIONS
      station_action = gets.chomp.to_i
      case station_action
      when 1 # Просмотр списка станций
      list_stations
      when 2 # Создать станцию
      manage_station
      end
    when 2 # routes
      puts "Выберите действие с маршрутами:"
      puts ROUTES_ACTIONS
      route_action = gets.chomp.to_i
      case route_action
      when 1 # Просмотр списка маршрутов
      list_routes
      when 2 # Создать маршрут
      manage_route
      when 3 # Показать маршрут
      show_route
      when 4 # Добавить станцию в маршрут
      add_station_to_route
      when 5 # Удалить станцию из мрашрута
      delete_station
      when 6 # Перемещение поезда по маршруту вперед
      forward_move
      when 7 # Перемещение поезда по маршруту назад
      backward_move
      end 
    when 3 # trains
      puts "Выберите дейсrail_road = RailRoad.newе с поездами:"
      puts TRAINS_ACTIONS# Бесконечный цикл
      train_action = gets.chomp.to_i
      case train_action
      when 1 # Просмотр списка поездов на станции
      list_trains 
      when 2 # Создать поезд
      manage_train
      when 3 # Назначать маршрут поезду
      assign_route_to_train
      when 4 # Добавлять вагоны к поезду
      car_add
      when 5 # Отцеплять вагоны от поезда
      car_remove
      end
    end
  end
  end

  private

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end
  
  ACTIONS = [
    "1 - станции",
    "2 - маршруты",
    "3 - поезда",
    "0 - выход из программы",
  ]

  STATIONS_ACTIONS = [
    "1 - показать список всех станций",
    "2 - создать станцию",
    "(любой другой номер) - отмена",
  ]

  ROUTES_ACTIONS = [
    "1 - показать список маршрутов",
    "2 - создать маршрут",
    "3 - показать маршрут",
    "4 - добавить станцию в маршрут",
    "5 - удалить станцию из маршрута",
    "6 - переместить поезд по маршруту вперед",
    "7 - переместить поезд по маршруту назад",
    "(любой другой номер) - отмена",
  ]
  
  TRAINS_ACTIONS = [
    "1 - показать список поездов",
    "2 - создать поезд",
    "3 - назначать маршрут поезду",
    "4 - добавлять вагоны к поезду",
    "5 - отцеплять вагоны от поезда",
    "(любой другой номер) - отмена",
  ]

  def list_stations
    @stations.each.with_index do |station, index|
      puts "Cписок станций: #{index} #{station.name}"
    end
  end

  def list_routes
    @routes.each.with_index do |route, index|
      puts "#{index}: Маршрут #{route}"
    end
  end

  def list_trains(train_type)
    @trains.each.with_index do |train, index|
      puts "#{index}: Поезд #{train.number}" if train.type == train_type
    end
  end

  # метод для поиска станции
  # - в аргументах передаем имя станции
  # - ищем в списке станций по переданному имени
  # - возвращает найденную станцию из списка станций
  def find_station(name)
    @stations.find { |station| station.name == name }
  end

  # метод для создания станции
  # - создает новую станцию
  # - добавляет станцию в список станций
  # - возвращает созданную станцию
  def create_station(name)
    new_station = Station.new(name) 
    @stations << new_station
    new_station
  end

  # Добавляем станцию по названию станции, если она еще не создана
  # Возвращаем существующую станцию (объект класса), если она уже есть с таким именем
  # или создаем и возвращаем новую станцию
  # (используем предыдущие два метода)
  def add_station(name)
    station = find_station(name) # вернет станцию или nil
    return station if station

    create_station(name)
  end

  def manage_station
    puts "Добавление станции:" 
    print "Введите название станции: "
    station_name = gets.chomp
     if station_name
        add_station(station_name)
        puts "Станция добавлена"
      else
        puts "Необходимо указать название станции"
      end
  end
  
  # метод для поиска маршрута по имени
  def find_route(name)
    @routes.find { |route| route.name == name }
  end

  # метод создает и возвращает новый маршрут с указанием первой и последней станций
  # добавляет созданный маршрут в список маршрутов
  def create_route(name, first_station, last_station)
    route = Route.new(name, first_station, last_station)
    @routes << route 
    route
  end
  
  def add_route(name, first_station, last_station)
    route = find_route(name)
    return route if route

    create_route(name, first_station, last_station)
  end

  def manage_route
    puts "Добавление маршрута: "
      print "Введите название маршрута: "
      route_name = gets.chomp
      print "Введите название начальной станции: "
      station1_name = gets.chomp
      print "Введите название конечной станции: "
      station2_name = gets.chomp
      if route_name && station1_name && station2_name
        station1 = add_station(station1_name)
        station2 = add_station(station2_name)
        add_route(route_name, station1_name, station2_name)
        puts "Маршрут добавлен"
      else
        puts "Необходимо указать все названия"
      end
  end
    
  def add_station_to_route
    puts "Добавление станции в маршрут:"
    print "Введите название маршрута в который нужно добавить станцию: "
    route_name = gets.chomp
    print "Введите название станции которую нужно добавить: "
    new_station = gets.chomp
      if route_name
      route = find_route(route_name)
        if route
          route.add_station(new_station)
        else 
         puts "Маршрут '#{route_name}' не найден"
        end
      else 
        puts "Необходимо ввести название маршрута"
      end 
  end

  def show_route
    puts "Отображение маршрута:"
    print "Введите название маршрута: "
    route_name = gets.chomp
      if route_name
        route = find_route(route_name)
          if route
            route.stations.each.with_index(1) do |station, index|
              puts "#{index}. #{station}"
            end
          else
            puts "Маршрут '#{route_name}' не найден"
          end
      else 
        puts "Необходимо ввести название маршрута"
      end   
  end   
   
  def delete_station
    puts "Удаление станции из маршрута:"
    print "Введите название маршрута из которого необходимо удалить станцию: "
    route_name = gets.chomp
    print "Введите название станции, которую нужно удалить: "
    station_name = gets.chomp
      if route_name
      route = find_route(route_name)
        if route
          route.delete_station(station_name)
          puts "Станция #{station_name} удалена из маршрута"
        else 
          puts "Необходимо ввести название маршрута из которого необходимо удалить станцию"
        end
      else
        puts "Маршрут '#{route_name}' не найден"
      end
  end

  def forward_move
    puts "Перемещение поезда по маршруту вперед:"
    print "Для перемещения вперед введите Forward: "
    forward = gets.chomp
      if forward
        move_forward
        puts "Перемещение вперед"
      else
        "Для движения вперед необходимо ввести Forward"
      end
  end

  def backward_move
    puts "Перемещение поезда по маршруту назад"
    print "Для перемещения поезда назад введите Backward: "
    backward = gets.chomp
      if backward
        move_backward
        puts "Перемещение назад"
      else
        puts "Для перемещения назад необходимо ввести Backward"
      end
  end
      
  # метод для поиска поезда по его номеру
  def find_train(train_number, train_type)
    @trains.find { |train| train.number == train_number && train.type == train_type}
  end
  
  # создаем поезд указанного типа, по умолчанию - пассажирский
  # добавляем созданный поезд в список поездов
  # возвращаем созданный поезд
  def create_train(train_number, train_type)
    train =
      if train_type == :cargo
        CargoTrain.new(train_number)
      else
        PassengerTrain.new(train_number)
      end
    @trains << train
    train
  end

  def add_train(train_number, train_type)
    train = find_train(train_number, train_type)
    return train if train

    create_train(train_number, train_type)
  end
  
  def manage_train
    puts "Добавление поезда:"
    print "Введите номер поезда: "
    train_number = gets.chomp.to_i
    print "Введите тип поезда (грузовой или пассажирский): "
    train_type = gets.chomp
      if train_number && train_type
        add_train(train_number, train_type)
        puts "Поезд добавлен"
      else
        puts "Необходимо указать номер и тип поезда"
      end
  end

  def assign_route_to_train
    puts "Назначение маршрута поезду: "
    print "Введите номер поезда, которому нужно назначить маршрут: "
    train_number = gets.chomp.to_i
    print "Введите тип поезда, которому нужно назначить маршрут: "
    train_type = gets.chomp
      if train_number && train_type
      train = find_train(train_number, train_type)
        if train 
          print "Введите название маршрута: "
          route_name = gets.chomp
            if route_name
              route = find_route(route_name)
                if route
                  train.assign_route(route_name)
                  puts "Поезду #{train_number} #{train_type} назначен маршрут #{route}"
                else
                  puts "Маршрут #{route} не найден"
                end
            else
              puts "Необходимо ввести название маршрута"
            end
        else  
          puts "Поезд #{train_number} #{train_type} не найден"   
        end
      else 
        puts "Необходимо ввести номер и тип поезда"
      end
  end

  def car_add
    puts "Добавление вагонов к поезду: "
    print "Введите номер поезда, к которому нужно добавить вагон: "
    train_number = gets.chomp.to_i
    print "Введите тип поезда, к которому нужно добавить вагон: "
    train_type = gets.chomp.to_sym
      if train_number && train_type
        train = find_train(train_number, train_type)
          if train 
            print "Введите тип вагона - cargo/passenger: "
            car_type = gets.chomp.to_sym
              if car_type
                if car_type == :cargo
                  car = CargoCar.new
                else
                  car = PassengerCar.new
                end
                train.add_car(car)
                puts "Вагон добавлен"
              else
                puts "Необходимо ввести тип вагона"
              end
          else 
            puts "Поезд #{train_number} #{train_type} не найден" 
          end
      else
        "Необходимо ввести номери и тип поезда"
      end
  end

  def car_remove
    puts "Отцепление вагона от поезда:"
    print "Введите номер поезда, от которого нужно отцепить вагон: "    
    train_number = gets.chomp.to_i    
    print "Введите тип поезда, от которого нужно отцепить вагон: "
    train_type = gets.chomp.to_sym
      if train_number && train_type
        train = find_train(train_number, train_type)
          if train 
            train.remove_car(car)
            puts "Вагон отцеплен"
          else
            puts "Поезд не найден"
          end
      else
        puts "Необходимо ввести  номер поезда и тип поезда, от которого нужно отцепить вагон"
      end
  end
end