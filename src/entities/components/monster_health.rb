class MonsterHealth < Health
  attr_accessor :health

  def initialize(object, object_pool, health)
    super(object, object_pool, health, true)
  end
end