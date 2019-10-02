class ScoreDisplay
  def initialize(object_pool)
    player = object_pool.objects.select do |o|
      o.class == Player
    end
    stats = player.first.input.stats
    create_stats_image(stats)
  end

  def create_stats_image(stats)
    @stats_image = Gosu::Image.from_text(
      $window, stats.to_s, Gosu.default_font_name, 30)
  end

  def draw
    @stats_image.draw(
      $window.width / 2 - @stats_image.width / 2,
      $window.height / 4 + 30,
      1000)
  end
end
