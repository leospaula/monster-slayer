module Model
  class Trophy < ::ActiveRecord::Base
    has_many :goals
  end
end