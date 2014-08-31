class BattingAverageChange
  class MostImprovedResult
    attr_reader :from_stat, :to_stat
    
    def initialize(from_stat, to_stat)
      @from_stat = from_stat
      @to_stat = to_stat
    end
    
    def to_s
      "#{player} had the most improved batting average from #{from_stat.year} to #{to_stat.year}: " +
        if change > 0
          "improved from #{from_stat.batting_average} to #{to_stat.batting_average}"
        elsif change < 0
          "declined from #{from_stat.batting_average} to #{to_stat.batting_average}"
        else
          "no change"
        end
    end
    
    def player
      @player ||= @from_stat.player
    end
    
    def change
      @change ||= @to_stat.batting_average - @from_stat.batting_average
    end
  end
  
  attr_reader :from_year, :to_year, :minimum_at_bats
  
  def initialize(from_year, to_year, minimum_at_bats: 200)
    @from_year = from_year
    @to_year = to_year
    @minimum_at_bats = minimum_at_bats
  end
  
  def most_improved
    most_improved = 0
    from_stat = nil
    to_stat = nil
    
    stats_by_player_id.each do |player_id, stats|
      next if stats.length != 2 # Skip players who didn't play both years
      from = stats.first
      to = stats.last
      change = to.batting_average - from.batting_average
      if change > most_improved
        most_improved = change
        from_stat = from
        to_stat = to
      end
    end
    
    MostImprovedResult.new(from_stat, to_stat)
  end
  
  private
  
  def stats_by_player_id
    HittingStat.for_years(from_year, to_year).where(["at_bats >= ?", minimum_at_bats]).order("player_id, year").inject({}) do |stats, stat|
      player = stat.player_id
      stats[player] ||= []
      stats[player] << stat
      stats
    end
  end
end