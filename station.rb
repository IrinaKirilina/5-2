# Станция
# 1. Имеет название, которое указывается при ее создании
# 2. Может принимать поезда (по одному за раз)
# 3. Может возвращать список всех поездов на станции
# 4. Может возвращать список поездов на станции по типу грузовые, пассажирские
# 5. Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

class Station 
  attr_reader :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  private

  def arrival(train)
    @trains << train
  end
  
  def departure(train)
    @trains.delete(train)
  end
end