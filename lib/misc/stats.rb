class Stats
  attr_reader :player, :kills, :deaths, :coins, :changed, :rewards
  def initialize(player)
    @player = player
    @kills = @player.model.killed_monsters.count
    @deaths = @player.model.deaths.count
    @coins = @player.model.collected_coins.sum(&:value)
    @rewards = @player.model.rewards.includes(:goal).map do |reward|
      goal = reward.goal
      trophy = goal.trophy
      {
        trophy_description: [goal.description, trophy.name].join(' - '),
        trophy_image: trophy.image
      }
    end
  end

  def to_s
    "Kills: #{kills} \n" \
    "Deaths: #{deaths} \n" \
    "Coins: #{coins} \n" \
    "Trophies: \n"\
    "#{rewards.map{ |h| h[:trophy_description] }.join("\n")}"
  end
end
