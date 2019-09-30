class PlayerPhysics < Component
  attr_accessor :speed, :in_collision, :collides_with

  def initialize(game_object, object_pool)
    super(game_object)
    @object_pool = object_pool
    @map = object_pool.map
    game_object.x, game_object.y = @map.find_spawn_point
    @speed = 0
  end

  def can_move_to?(x, y)
    old_x, old_y = object.x, object.y
    object.x = x
    object.y = y
    return false unless @map.can_move_to?(x, y)
    @object_pool.nearby(object, 100).each do |obj|
      if collides_with_poly?(obj.box)
        @collides_with = obj
        old_distance = Utils.distance_between(
          obj.x, obj.y, old_x, old_y)
        new_distance = Utils.distance_between(
          obj.x, obj.y, x, y)
        return false if new_distance < old_distance
      else
        @collides_with = nil
      end
    end
    true
  ensure
    object.x = old_x
    object.y = old_y
  end

  def moving?
    !object.stopped
  end

  def box_height
    @box_height ||= object.graphics.height
  end

  def box_width
    @box_width ||= object.graphics.width
  end

  def box
    w = box_width / 2 - 1
    h = box_height / 2 - 1
  end

  def update
    if moving?
      @speed = 3
    else
      @speed = 0
    end

    if @speed > 0
      new_x, new_y = x, y
      case @object.direction
      when :up
        new_y -= @speed
      when :right
        new_x += @speed
      when :down
        new_y += @speed
      when :left
        new_x -= @speed
      end
      if can_move_to?(new_x, new_y)
        object.x, object.y = new_x, new_y
        @in_collision = false
      else
        @speed = 0
        @in_collision = true
      end
    end
  end
end
