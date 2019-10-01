class PlayState < GameState
  attr_accessor :update_interval

  def initialize
    @object_pool = ObjectPool.new
    @map = WorldMap.new(@object_pool)
    @camera = Camera.new
    @player = Player.new(@object_pool, PlayerInput.new(@camera))
    @camera.target = @player
    @object_pool.camera = @camera

    30.times do |i|
      Monster.new(@object_pool)
    end
  end

  def update
    @object_pool.objects.map(&:update)
    @object_pool.objects.reject!(&:removable?)
    @camera.update
    update_caption
  end

  def draw
    cam_x = @camera.x
    cam_y = @camera.y
    off_x =  $window.width / 2 - cam_x
    off_y =  $window.height / 2 - cam_y
    viewport = @camera.viewport
    $window.translate(off_x, off_y) do
      zoom = @camera.zoom
      $window.scale(zoom, zoom, cam_x, cam_y) do
        @map.draw(viewport)
        @object_pool.objects.map { |o| o.draw(viewport) }
      end
    end
  end

  def button_down(id)
    if id == Gosu::KbQ
      leave
      $window.close
    end
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end

  private

  def update_caption
    now = Gosu.milliseconds
    if now - (@caption_updated_at || 0) > 1000
      $window.caption = 'Monster Slayer. ' <<
        "[FPS: #{Gosu.fps}] "
      @caption_updated_at = now
    end
  end
end