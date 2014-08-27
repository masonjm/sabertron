class HittingStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  
  validates :player, :team, :year, presence: true
  validates :games, presence: true, numericality: {greater_than: 0}
  
  scope :with_batting_average, -> do
    t = table_name
    select("#{t}.*, (#{t}.singles + #{t}.doubles + #{t}.triples + #{t}.home_runs) / #{t}.at_bats AS batting_average")
  end
  
  scope :for_years, -> (*years) do
    where(["#{table_name}.year IN (?)", years])
  end
end
