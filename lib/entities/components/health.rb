class Health < Component
  attr_accessor :health

  def initialize(object, object_pool, health, should_draw)
    super(object)
    @object_pool = object_pool
    @initial_health = @health = health
    @health_updated = true
    @should_draw = should_draw
  end

  def restore
    @health = @initial_health
    @health_updated = true
  end

  def dead?
    @health < 1
  end

  def update
    update_image
  end

  def inflict_damage(player, amount)
    if @health > 0
      @health_updated = true
      @health = [@health - amount.to_i, 0].max
      after_death(player) if dead?
    end
  end

  def draw(viewport)
    return unless @should_draw
    @image && @image.draw(
      x - @image.width / 2,
      y - object.graphics.height / 2 -
      @image.height, 100)
  end

  protected

  def update_image
    return unless @should_draw
    if @health_updated
      text = @health.to_s
      font_size = 18
      @image = Gosu::Image.from_text(
          $window, text,
          Gosu.default_font_name, font_size)
      @health_updated = false
    end
  end

  def after_death(player)
    if object.class == Monster
      Model::KilledMonster.create(
        user_id: player.model.id,
        monster_id: object.model.id
      )

      Coin.new(@object_pool, x, y)
    end
  end
end
