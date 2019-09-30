class ObjectPool
  attr_accessor :objects, :map, :camera

  def initialize
    @objects = []
  end

  def nearby(object, max_distance)
    @objects.select do |obj|
      distance = Utils.distance_between(
        obj.x, obj.y, object.x, object.y)
      obj != object && distance < max_distance
    end
  end
end
