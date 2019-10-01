require 'rmagick'

class MonsterGraphics < Component
  def initialize(game_object, monster_kind)
    super(game_object)
    @walking = build_walking(monster_kind)
    @dead = Gosu::Image.new(Utils.media_path('bone.png'))
  end

  def draw(viewport)
    if object && object.health.dead?
      @dead.draw_rot(
        x, y, 1,
        Utils.direction_angle(object.direction),
        0.5, 0.5, 0.5, 0.5)
    else
      @walking.draw(object.direction, x, y, animate: !object.stopped)
    end
  end

  def width
    body.width
  end

  def height
    body.height
  end

  private

  def body
    if object && object.health.dead?
      @dead
    else
      @walking
    end
  end

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
