module Model
  class Goal < ::ActiveRecord::Base
    belongs_to :trophy
    has_many :rewards

    def completed_by?(user)
      !!reward_for(user)
    end

    def complete_for(user)
      unless completed_by?(user)
        Model::Reward.create!(goal: self, user: user)
      end
    end

    private

    def reward_for(user)
      rewards.find_by(user: user)
    end
  end
end