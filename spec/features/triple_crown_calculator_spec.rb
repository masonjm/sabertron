require 'rails_helper'

describe "TripleCrownCalculator", :type => :feature do
  subject { TripleCrownCalculator.new(2011) }
  
  describe "highest_batting_average" do
    let!(:team) { create(:team) }
    let!(:stat1) { create(:hitting_stat, year: 2011, team: team, singles: 1, at_bats: 400) }
    let!(:stat2) { create(:hitting_stat, year: 2011, team: team, singles: 1, at_bats: 600) }
    
    it "returns player with highest batting average" do
      expect(subject.highest_batting_average(team.league)).to eq [stat1.player]
    end
    
    it "ignores players with too few at_bats" do
      calculator = TripleCrownCalculator.new(2011, minimum_at_bats: 500)
      expect(calculator.highest_batting_average(team.league)).to eq [stat2.player]
    end
  end
  
  describe "most_home_runs" do
    let!(:team) { create(:team) }
    let!(:stat1) { create(:hitting_stat, year: 2011, team: team, home_runs: 2) }
    let!(:stat2) { create(:hitting_stat, year: 2011, team: team, home_runs: 1) }
    
    it "returns player with most home runs" do
      expect(subject.most_home_runs(team.league)).to eq [stat1.player]
    end
  end
  
  describe "most_rbi" do
    let!(:team) { create(:team) }
    let!(:stat1) { create(:hitting_stat, year: 2011, team: team, rbi: 2) }
    let!(:stat2) { create(:hitting_stat, year: 2011, team: team, rbi: 1) }
    
    it "returns player with most rbi" do
      expect(subject.most_rbi(team.league)).to eq [stat1.player]
    end
  end
  
  describe "winners" do
    
    context "with no winner" do
      let!(:team) { create(:team, league: "AL") }
      let!(:stat1) { create(:hitting_stat, year: 2011, team: team, home_runs: 1, at_bats: 400) }
      let!(:stat2) { create(:hitting_stat, year: 2011, team: team, rbi: 2, at_bats: 400) }
      
      it "returns '(No result)'" do
        expect(subject.winners.al_winner).to eq "(No winner)"
      end
    end
    
    context "with a winner" do
      let!(:team) { create(:team, league: "AL") }
      let!(:stat1) { create(:hitting_stat, year: 2011, team: team, home_runs: 1, rbi: 2, at_bats: 400) }
      let!(:stat2) { create(:hitting_stat, year: 2011, team: team, at_bats: 400) }
      
      it "returns the winner" do
        expect(subject.winners.al_winner).to eq stat1.player
      end
    end
    
    context "with tied home_runs" do
      let!(:team) { create(:team, league: "AL") }
      let!(:stat1) { create(:hitting_stat, year: 2011, team: team, home_runs: 1, rbi: 2, at_bats: 400) }
      let!(:stat2) { create(:hitting_stat, year: 2011, team: team, home_runs: 1, at_bats: 400) }
      
      it "returns the winner" do
        expect(subject.winners.al_winner).to eq stat1.player
      end
    end
    
  end
end