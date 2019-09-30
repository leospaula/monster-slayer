require 'rmagick'

class MonsterGraphics < Component
  def initialize(game_object, monster_kind)
    super(game_object)
    @walking = build_walking(monster_kind)
  end

  def draw(viewport)
    @walking.draw(object.direction, x, y, animate: !object.stopped)
  end

  def width
    @walking.width
  end

  def height
    @walking.height
  end

  private

  def build_walking(kind)
    if kind == :imp
      Animation.new(Utils.media_path('imp.png'),
        width: 47, height: 67, length: 3, rows: 4, columns: 3
      ) do |rows|
        {
          up: rows[0],
          down: rows[2],
          left: rows[1].clone.map { |image| flop_image(image) },
          right: rows[1]
        }
      end
    else
      Animation.new(Utils.media_path('winged_blue_imp.png'),
        width: 64, height: 67, length: 3, rows: 4, columns: 3
      ) do |rows|
        {
          up: rows[0],
          down: rows[2],
          left: rows[1].clone.map { |image| flop_image(image) },
          right: rows[1]
        }
      end
    end
  end

  def flop_image(image)
    Gosu::Image.new(rmagick_image(image).flop!)
  end

  def rotate_image(image, degrees)
    Gosu::Image.new(rmagick_image(image).rotate!(degrees))
  end

  def rmagick_image(image)
    Magick::Image.from_blob(image.to_blob) {
      self.format = "RGBA"
      self.depth = 8
      self.size = "#{image.width}x#{image.height}"
    }.first
  end
end