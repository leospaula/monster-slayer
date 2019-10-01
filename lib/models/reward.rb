module Model
  class Reward < ::ActiveRecord::Base
    belongs_to :goal
    belongs_to :user
  end
end