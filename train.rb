# Может возвращать текущую скорость, текущую станцию 
# Имеет номер (произвольная строка), тип (грузовой, пассажирский), вагоны
# Может набирать скорость
# Может тормозить (сбрасывать скорость до нуля)
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию)/ Mетод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать текущую, следующую, предыдущую станцию

class Train
  attr_reader :number, :type, :cars, :speed, :route, :current_station_index

  def initialize(number)
    @number = number
    @speed = 0
    @route = route
    @current_station_index = current_station_index
    @cars = []
  end

  def add_car(car)
    cars << car if train_stopped? && train.type == car.type
  end

  def remove_car
    cars.delete(car) if train_stopped? && cars.count.positive?
  end

  def assign_route(route)
    @route = route
    @current_station_index = 1
  end

  def move_forward
    @current_station_index += 1 if route && !last_staion?
  end

  def move_backward
    @current_station_index -= 1 if route && !first_station?
  end

  def previous_station
    route.stations[current_station_index - 2].name if !first_station?
  end

  def current_station
    route.stations[current_station_index - 1].name
  end

  def next_station
    route.stations[current_station_index].name if !last_station?
  end

  private

  def accelerate
    speed += 1
  end

  def deccelerate
    speed -= 1 unless train_stopped?
  end

  def first_station?
    current_station_index == 1
  end

  def last_station?
    current_station_index == route.stations.count
  end
  
  def train_stopped?
    speed == 0
  end
end