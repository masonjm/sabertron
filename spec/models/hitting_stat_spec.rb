require 'rails_helper'

RSpec.describe HittingStat, :type => :model do
  describe "validations" do
    it { should validate_presence_of :player }
    it { should validate_presence_of :team }
    it { should validate_presence_of :year }
    it { should validate_presence_of :games }
    it { should validate_numericality_of(:games).is_greater_than(0) }
  end
  
  describe "associations" do
    it { should belong_to :team }
    it { should belong_to :player }
  end
  
  describe "hits" do
    subject { build(:hitting_stat, singles: 1, doubles: 1, triples: 1, home_runs: 1) }
    
    it "equals singles + doubles + triples + home_runs" do
      expect(subject.hits).to eq 4
    end
  end
  
  describe "batting average" do
    subject { build(:hitting_stat, singles: 1, doubles: 1, triples: 1, home_runs: 1, at_bats: 4) }
    
    it "equals hits / at_bats" do
      expect(subject.batting_average).to eq 1
    end
    
    context "with 0 at_bats" do
      subject { build(:hitting_stat, at_bats: 0) }
      
      it "equals 0" do
        expect(subject.batting_average).to eq 0
      end
    end
  end
  
  describe "slugging percentage" do
    subject { build(:hitting_stat, singles: 1, doubles: 1, triples: 1, home_runs: 1, at_bats: 4) }
    
    it "equals (1B+(2*2B)+(3*3B)+(4*HR)) / at_bats" do
      expect(subject.slugging_percentage).to eq 2.5
    end
    
    context "with 0 at_bats" do
      subject { build(:hitting_stat, at_bats: 0) }
      
      it "equals 0" do
        expect(subject.slugging_percentage).to eq 0
      end
    end
  end
end
