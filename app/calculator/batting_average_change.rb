class BattingAverageChange
  class Result
    attr_reader :player, :change
    
    def initialize(player: nil, change: nil)
      @player = player
      @change = change
    end
  end
  
  attr_reader :from_year, :to_year, :minimum_at_bats
  
  def initialize(from_year, to_year, minimum_at_bats: 200)
    @from_year = from_year
    @to_year = to_year
    @minimum_at_bats = minimum_at_bats
  end
  
  def most_improved
    player = nil
    most_changed = 0
    players_with_batting_averages.each_slice(2) do |stats|
      from = stats.first
      to = stats.last
      puts to.batting_average
      puts from.batting_average
      player_change = to.batting_average - from.batting_average
      if player_change > most_changed
        player = from.player
        most_changed = player_change
      end
    end
    Result.new(player: player, change: most_changed)
  end
  
  private
  
  def players_with_batting_averages
    HittingStat.with_batting_average.for_years(from_year, to_year).where(["at_bats >= ?", minimum_at_bats]).order("player_id, year")
  end
end