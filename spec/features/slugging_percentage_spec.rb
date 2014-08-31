require 'rails_helper'

describe "SluggingPercentage", :type => :feature do
  subject { SluggingPercentage.new(2007) }
  
  describe "for_team" do
    let(:team) { create(:team, code: "TEST") }
    let(:player) { create(:player, first_name: "Darth", last_name: "Ruth") }
    let!(:stat) { create(:hitting_stat, player: player, team: team, singles: 1, at_bats: 1) }
    
    it "outputs table of slugging percentages" do
      result = subject.for_team(team.code)
      expected = <<EOS
Slugging Percentage for TEST in 2007:
Player               | %
---------------------+-------
Darth Ruth           | 1.000%
EOS
      expected.strip!
      expect(result.to_s).to eq expected
    end
  end
end