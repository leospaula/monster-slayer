class CollectedCoinObserver
  def self.call(collected_coin)
    user = collected_coin.user
    user_rewards = user.rewards.pluck(:goal_id)
    coins_collected = user.collected_coins.sum(&:value)

    Model::Goal
      .where.not(id: user_rewards)
      .where(category: 'coin')
      .each do |goal|
      if coins_collected >= goal.value
        goal.complete_for user
      end
    end
  end
end