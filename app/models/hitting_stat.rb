class HittingStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  
  validates :player, :team, :year, presence: true
  validates :games, presence: true, numericality: {greater_than: 0}
  
  scope :for_years, -> (*years) do
    where(["#{table_name}.year IN (?)", years])
  end
  
  def hits
    singles + doubles + triples + home_runs
  end
  
  def batting_average
    return 0 if at_bats == 0
    hits.to_f / at_bats
  end
end
