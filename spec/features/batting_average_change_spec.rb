require 'rails_helper'

describe "BattingAverageChange", :type => :feature do
  subject { BattingAverageChange.new(2009, 2010) }
  
  describe "most_improved" do
    it "works for a single player" do
      player = create(:player)
      create(:hitting_stat, player: player, year: 2009, at_bats: 200, singles: 100)
      create(:hitting_stat, player: player, year: 2010, at_bats: 200, singles: 200)
      result = subject.most_improved
      
      expect(result.player).to eq player
      expect(result.change).to eq 0.5
    end
    
    it "works for multiple players" do
      player1 = create(:player)
      create(:hitting_stat, player: player1, year: 2009, at_bats: 200, singles: 100)
      create(:hitting_stat, player: player1, year: 2010, at_bats: 200, singles: 200)
      
      player2 = create(:player)
      create(:hitting_stat, player: player2, year: 2009, at_bats: 200, singles: 100)
      create(:hitting_stat, player: player2, year: 2010, at_bats: 200, singles: 150)
      
      result = subject.most_improved
      
      expect(result.player).to eq player1
      expect(result.change).to eq 0.5
    end
    
    it "ignores players with less than 200 at_bats" do
      player = create(:player)
      create(:hitting_stat, player: player, year: 2009, at_bats: 199, singles: 100)
      create(:hitting_stat, player: player, year: 2010, at_bats: 199, singles: 200)
      result = subject.most_improved
      
      expect(result.player).to eq nil
    end
  end
end