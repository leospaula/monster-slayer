class Player < GameObject
  attr_accessor :x, :y, :attack, :direction, :stopped,
                :physics, :graphics, :health

  def initialize(object_pool, input)
    super(object_pool)
    @input = input
    @input.control(self)
    @attack = false
    @direction = :down
    @stopped = true
    @physics = CharacterPhysics.new(self, object_pool)
    @graphics = PlayerGraphics.new(self)
    @health = PlayerHealth.new(self, object_pool)
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

  def box
    @physics.box
  end

  def on_collision(object)
    return unless object
    if object.class == Monster
      object.input.on_collision(object)
    else
      object.on_collision(self)
    end
  end
end
