module Model
  class KilledMonster < ::ActiveRecord::Base
    include CheckGoalsModule

    belongs_to :user
    belongs_to :monster

    private

    def observer
      KilledMonsterObserver
    end
  end
end