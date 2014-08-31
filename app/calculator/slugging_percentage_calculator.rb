class SluggingPercentageCalculator
  class TeamResult
    include ActionView::Helpers::NumberHelper
    
    attr_reader :year, :stats
    
    def initialize(year, stats)
      @year = year
      @stats = stats
    end
    
    def to_s
      s = []
      s << "Slugging Percentage for #{stats.first.team} in #{year}:"
      s << row("Player", "")
      s << "---------------------+-------"
      stats.each do |stat|
        s << row(stat.player, stat.slugging_percentage)
      end
      s.join("\n")
    end
    
    private
    
    def row(player, percentage)
      "%-20s | %s" % [player, number_to_percentage(percentage)]
    end
  end
  
  attr_reader :year
  
  def initialize(year)
    @year = year
  end
  
  def for_team(team_code)
    TeamResult.new(year, HittingStat.for_team(team_code).with_players.group(:player_id).order("players.last_name, players.first_name"))
  end
end