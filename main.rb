# Текстовый интерфейс позволяет пользователю делать следующее:
# Создавать станции
# Создавать поезда
# Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# Назначать маршрут поезду
# Добавлять вагоны к поезду
# Отцеплять вагоны от поезда
# Перемещать поезд по маршруту вперед и назад
# Просматривать список станций и список поездов на станции

require_relative "./rail_road"

rail_road = RailRoad.new
puts "Управление железной дорогой"
loop do
  puts "------------------"
  puts "Выберите действие:"
  puts rail_road.actions
  action = gets.chomp.to_i
  case action
  when 0
    break # выходим из цикла "loop do"
  when 1 # stations
    puts "Выберите действие со станциями:"
    puts rail_road.stations_actions
    station_action = gets.chomp.to_i
    case station_action
    when 1 # Просмотр списка станций
      rail_road.list_stations
    when 2 # Создать станцию
      rail_road.manage_station
    end
  when 2 # routes
    puts "Выберите действие с маршрутами:"
    puts rail_road.routes_actions
    route_action = gets.chomp.to_i
    case route_action
    when 1 # Просмотр списка маршрутов
      rail_road.list_routes
    when 2 # Создать маршрут
      rail_road.manage_route
    when 3 # Показать маршрут
      rail_road.show_route
    when 4 # Добавить станцию в маршрут
      rail_road.add_station_to_route
    when 5 # Удалить станцию из мрашрута
      rail_road.delete_station
    when 6 # Перемещение поезда по маршруту вперед
      rail_road.forward_move
    when 7 # Перемещение поезда по маршруту назад
      rail_road.backward_move
    end 
  when 3 # trains
    puts "Выберите действие с поездами:"
    puts rail_road.trains_actions
    train_action = gets.chomp.to_i
    case train_action
    when 1 # Просмотр списка поездов на станции
      rail_road.list_trains 
    when 2 # Создать поезд
      rail_road.manage_train
    when 3 # Назначать маршрут поезду
      rail_road.assign_route_to_train
    when 4 # Добавлять вагоны к поезду
      rail_road.car_add
    when 5 # Отцеплять вагоны от поезда
      rail_road.car_remove
    end
  end
end