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
    al_winner, nl_winner = ["AL", "NL"].collect do |league|
      find_winner(league)
    end
    TripleCrownResult.new(al_winner: al_winner, nl_winner: nl_winner, year: year)
  end
  
  def highest_batting_average(league)
    hitting_stats = stats(league).sort_by(&:batting_average)
    max = hitting_stats.last.try(:batting_average)
    hitting_stats.select do |stat|
      stat.batting_average == max
    end.map(&:player)
  end
  
  def most_home_runs(league)
    max = stats(league).pluck("max(home_runs)")
    stats(league).where(home_runs: max).map(&:player)
  end
  
  def most_rbi(league)
    max = stats(league).pluck("max(rbi)")
    stats(league).where(rbi: max).map(&:player)
  end
  
  private
  
  def stats(league)
    HittingStat.for_years(year).for_league(league).with_players
  end
  
  def find_winner(league)
    hitters = highest_batting_average(league)
    homers = most_home_runs(league)
    assisters = most_rbi(league)
    hitters.each do |hitter|
      return hitter if hitter.in?(homers) && hitter.in?(assisters)
    end
    nil
  end
end