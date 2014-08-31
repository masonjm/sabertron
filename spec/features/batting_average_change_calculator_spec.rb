require 'rails_helper'

describe "BattingAverageChangeCalculator", :type => :feature do
  subject { BattingAverageChangeCalculator.new(2009, 2010) }
  
  describe "most_improved" do
    it "works for a single player" do
      player = create(:player)
      from_stat = create(:hitting_stat, player: player, year: 2009, at_bats: 200, singles: 100)
      to_stat = create(:hitting_stat, player: player, year: 2010, at_bats: 200, singles: 200)
      result = subject.most_improved
      
      expect(result.from_stat).to eq from_stat
      expect(result.to_stat).to eq to_stat
    end
    
    it "works for multiple players" do
      player1 = create(:player)
      from_stat = create(:hitting_stat, player: player1, year: 2009, at_bats: 200, singles: 100)
      create(:hitting_stat, player: player1, year: 2010, at_bats: 200, singles: 200)
      
      player2 = create(:player)
      create(:hitting_stat, player: player2, year: 2009, at_bats: 200, singles: 100)
      create(:hitting_stat, player: player2, year: 2010, at_bats: 200, singles: 150)
      
      result = subject.most_improved
      
      expect(result.from_stat).to eq from_stat
    end
    
    it "ignores players with less than 200 at_bats" do
      player = create(:player)
      create(:hitting_stat, player: player, year: 2009, at_bats: 199, singles: 100)
      create(:hitting_stat, player: player, year: 2010, at_bats: 199, singles: 200)
      result = subject.most_improved
      
      expect(result.from_stat).to eq nil
    end
  end
end