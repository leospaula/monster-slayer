class KilledMonsterObserver
  def self.call(killed_monster)
    user = killed_monster.user
    user_rewards = user.rewards.pluck(:goal_id)
    killed_count = user.killed_monsters
      .joins(:monster)
      .where(monsters: { name: killed_monster.monster.name })
      .count

    Model::Goal
      .where.not(id: user_rewards)
      .where(category: 'monster')
      .each do |goal|
      if killed_count >= goal.value
        goal.complete_for user
      end
    end
  end
end