class PlayerInput < Component
  attr_reader :stats

  def initialize(camera)
    super(nil)
    @camera = camera
  end

  def control(obj)
    self.object = obj
    @stats = Stats.new(object)
  end

  def update
    motion_buttons = [Gosu::KbUp, Gosu::KbDown, Gosu::KbRight, Gosu::KbLeft]

    if any_button_down?(*motion_buttons)
      object.direction = change_direction(*motion_buttons)
      object.move
    else
      object.stop
    end

    if Utils.button_down?(Gosu::KbLeftShift)
      object.attack!
    end
  end

  private

  def any_button_down?(*buttons)
    buttons.each do |b|
      return true if Utils.button_down?(b)
    end
    false
  end

  def change_direction(up, down, right, left)
    if Utils.button_down?(up)
      :up
    elsif Utils.button_down?(down)
      :down
    elsif Utils.button_down?(left)
      :left
    elsif Utils.button_down?(right)
      :right
    end
  end
end
