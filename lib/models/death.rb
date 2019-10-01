module Model
  class Death < ::ActiveRecord::Base
    include CheckGoalsModule
    belongs_to :user

    private

    def observer
      DeathObserver
    end
  end
end