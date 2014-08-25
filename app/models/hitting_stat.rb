class HittingStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  
  validates :player, :team, :year, presence: true
  validates :games, presence: true, numericality: {greater_than: 0}
end
