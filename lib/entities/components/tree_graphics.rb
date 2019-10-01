class TreeGraphics < Component
  def initialize(object, seed)
    super(object)
    load_sprite(seed)
  end

  def draw(viewport)
    @tree.draw(center_x, center_y, 5)
  end

  def height
    @tree.height
  end

  def width
    @tree.width
  end

  private

  def load_sprite(seed)
    frame_list = trees.frame_list
    frame = frame_list[(frame_list.size * seed).round]
    @tree = trees.frame(frame)
  end

  def center_x
    @center_x ||= x - @tree.width / 2
  end

  def center_y
    @center_y ||= y - @tree.height / 2
  end

  def trees
    @@trees ||= Gosu::TexturePacker.load_json(
      Utils.media_path('trees_packed.json')
    )
  end
end
