class TripleCrownCalculator
  class TripleCrownResult    
    attr_reader :year
    
    def initialize(al_winner: nil, nl_winner: nil, year: nil)
      @al_winner = al_winner
      @nl_winner = nl_winner
      @year = year
    end
    
    def to_s
      "Triple crown winners for #{year}:\n" +
      "League | Player\n" +
      "-------+-------------------\n" +
      "AL     | #{al_winner}\n" +
      "NL     | #{nl_winner}"
    end
    
    def al_winner
      @al_winner || no_winner
    end
    
    def nl_winner
      @nl_winner || no_winner
    end
    
    private
    
    def no_winner
      "(No winner)"
    end
  end
  
  attr_reader :year
  
  def initialize(year)
    @year = year
  end
  
  def winners
    # TODO: Handle ties. This algorithm is non-deterministic if a player is tied for first in one or more of the stats.
    al_winner, nl_winner = ["AL", "NL"].collect do |league|
      candidate = highest_batting_average(league)
      if candidate == most_home_runs(league) && candidate == most_rbi(league)
        candidate
      end
    end
    TripleCrownResult.new(al_winner: al_winner, nl_winner: nl_winner, year: year)
  end
  
  def highest_batting_average(league)
    stats(league).sort_by(&:batting_average).last.try(:player)
  end
  
  def most_home_runs(league)
    stats(league).order("home_runs desc").first.try(:player)
  end
  
  def most_rbi(league)
    stats(league).order("rbi desc").first.try(:player)
  end
  
  private
  
  def stats(league)
    HittingStat.for_years(year).for_league(league)
  end
end