class PlayerHealth < Health
  attr_accessor :health

  def initialize(object, object_pool)
    super(object, object_pool, 100, true)
  end
end
