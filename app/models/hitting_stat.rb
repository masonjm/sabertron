class HittingStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  
  validates :player, :team, :year, presence: true
  validates :games, presence: true, numericality: {greater_than: 0}
  
  scope :for_years, -> (*years) do
    where(["#{table_name}.year IN (?)", years])
  end
  
  scope :for_team, -> (team_code) do
    includes(:team).where(teams: {code: team_code})
  end
  
  scope :with_players, -> { includes(:player) }
  
  scope :for_league, -> (league) do
    joins(:team).where(teams: {league: league})
  end
  
  def hits
    singles + doubles + triples + home_runs
  end
  
  def batting_average
    return 0 if at_bats == 0
    hits.to_f / at_bats
  end
  
  def slugging_percentage
    return 0 if at_bats == 0
    (singles + 2 * doubles + 3 * triples + 4 * home_runs).to_f / at_bats
  end
end
