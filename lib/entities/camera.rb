class Camera
  attr_accessor :x, :y, :zoom

  def target=(target)
    @target = target
    @x, @y = target.x, target.y
    @zoom = 1
  end

  def can_view?(x, y, obj)
    x0, x1, y0, y1 = viewport
    (x0 - obj.width..x1).include?(x) &&
      (y0 - obj.height..y1).include?(y)
  end

  def update
    @x += @target.physics.speed if @x < @target.x - $window.width / 4
    @x -= @target.physics.speed if @x > @target.x + $window.width / 4
    @y += @target.physics.speed if @y < @target.y - $window.height / 4
    @y -= @target.physics.speed if @y > @target.y + $window.height / 4

    zoom_delta = @zoom > 0 ? 0.01 : 1.0
    if $window.button_down?(Gosu::KbW)
      @zoom -= zoom_delta unless @zoom < 0.7
    elsif $window.button_down?(Gosu::KbS)
      @zoom += zoom_delta unless @zoom > 10
    end
  end

  def to_s
    "FPS: #{Gosu.fps}. " <<
      "#{@x}:#{@y} @ #{'%.2f' % @zoom}. " <<
      'Arrows to move, +- to zoom.'
  end

  def target_delta_on_screen
    [(@x - @target.x) * @zoom, (@y - @target.y) * @zoom]
  end

  def viewport
    x0 = @x - ($window.width / 2)  / @zoom
    x1 = @x + ($window.width / 2)  / @zoom
    y0 = @y - ($window.height / 2) / @zoom
    y1 = @y + ($window.height / 2) / @zoom
    [x0, x1, y0, y1]
  end
end
