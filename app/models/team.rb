class Team < ActiveRecord::Base
  validates :code, :league, presence: true
end
