module CheckGoalsModule
  extend ActiveSupport::Concern

  included do
    after_create :check_goals
  end

  def check_goals
     observer.call(self)
  end

  private

  def observer
    # override
  end
end