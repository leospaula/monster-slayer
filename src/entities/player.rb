class Player < GameObject
  attr_accessor :x, :y, :attack, :direction, :stopped, :physics

  def initialize(object_pool, input)
    super(object_pool)
    @input = input
    @input.control(self)
    @attack = false
    @direction = :down
    @stopped = true
    @physics = PlayerPhysics.new(self, object_pool)
    @graphics = PlayerGraphics.new(self)
  end

  def change_direction=(new_direction)
    @direction = new_direction
  end

  def move
    @stopped = false
  end

  def attack!
    @attack = true
  end

  def stop
    @stopped = true
  end
end
