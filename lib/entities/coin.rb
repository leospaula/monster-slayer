class Coin < GameObject
  attr_reader :x, :y, :graphics, :value, :collected, :angle

  def initialize(object_pool, x, y)
    super(object_pool)
    @x, @y = x, y
    @graphics = CoinGraphics.new(self)
    @angle = rand(-15..15)
    @value = rand(1..5) * 10
    @collected = false
  end

  def on_collision(object)
    if object.class == Player
      object.coins += value
      Model::CollectedCoin.create(user_id: object.model.id, value: value)
      @collected = true
      mark_for_removal
    end
  end

  def box
    return [0, 0] if @collected
    [x, y]
  end
end