require 'rmagick'

class PlayerGraphics < Component
  def initialize(game_object)
    super(game_object)
    @walking = build_walking
    @attack_down = build_attack_down
  end

  def draw(viewport)
    if object.attack
      @attack_down.draw(object.direction, x, y)
      object.attack = @attack_down.in_progress?
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
    if object.attack
      @walking
    else
      @attack_down
    end
  end

  def build_walking
    Animation.new(Utils.media_path('character_walking.png'),
      width: 32, height: 41, length: 13, frame_rate: 10, rows: 3, columns: 13
    ) do |rows|
      {
        down: rows[0],
        left: rows[1].clone.map { |image| flop_image(image) },
        right: rows[1],
        up: rows[2],
      }
    end
  end

  def build_attack_down
    Animation.new(Utils.media_path('attack_down.png'),
      width: 38, height: 48, length: 8
    ) do |rows|
      {
        down: rows[0],
        left: rows[0].clone.map { |image| rotate_image(image, 90) },
        right: rows[0].clone.map { |image| rotate_image(image, 270) },
        up: rows[0].clone.map { |image| rotate_image(image, 180) },
      }
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
