class Monster < GameObject
  attr_accessor :x, :y, :direction, :stopped, :physics, :graphics, :health

  def initialize(object_pool, input=AiInput.new)
    super(object_pool)
    @input = input
    @input.control(self)
    @direction = [:up, :down, :left, :right].sample
    @stopped = true
    @kind = [:imp, :winged_imp].sample
    @physics = CharacterPhysics.new(self, object_pool)
    @graphics = MonsterGraphics.new(self, @kind)
    @health = MonsterHealth.new(self, object_pool, monster_health)
  end

  def move
    @stopped = false
  end

  def stop
    @stopped = true
  end

  def box
    @physics.box
  end

  private

  def monster_health
    if @kind == :imp
      20
    else
      50
    end
  end
end
