module Model
  class User < ::ActiveRecord::Base
    has_many :killed_monsters
    has_many :collected_coins
    has_many :deaths
    has_many :rewards
  end
end