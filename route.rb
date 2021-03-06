# Маршрут
# Имеет начальную и конечную станцию,
# а также список промежуточных станций.
# Начальная и конечная станции указываются при создании маршрута,
# а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :stations, :name
  
  def initialize(name, first_station, last_station)
    @stations = [first_station, last_station]
    @name = name
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end
end