module Model
  class Reward < ::ActiveRecord::Base
    belongs_to :goal
    belongs_to :user

    delegate :trophy, to: :goal
  end
end