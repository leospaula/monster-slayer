class DeathObserver
  def self.call(death)
    user = death.user
    user_rewards = user.rewards.pluck(:goal_id)
    deaths_count = user.deaths.count

    Model::Goal
      .where.not(id: user_rewards)
      .where(category: 'death')
      .each do |goal|
      if deaths_count >= goal.value
        goal.complete_for user
      end
    end
  end
end