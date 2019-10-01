module Model
  class CollectedCoin < ::ActiveRecord::Base
    include CheckGoalsModule

    belongs_to :user

    private

    def observer
      CollectedCoinObserver
    end
  end
end