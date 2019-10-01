class CoinGraphics < Component
  def initialize(object)
    super(object)
  end

  def draw(viewport)
    return if object.collected
    image.draw_rot(x, y, 1, object.angle)
  end

  def height
    image.height
  end

  def width
    image.width
  end

  private

  def image
    @@image ||= Gosu::Image.new(Utils.media_path('coins.png'))
  end
end
