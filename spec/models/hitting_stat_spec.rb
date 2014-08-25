require 'rails_helper'

RSpec.describe HittingStat, :type => :model do
  describe "validations" do
    it { should validate_presence_of :player }
    it { should validate_presence_of :team }
    it { should validate_presence_of :year }
    it { should allow_value("2000", "1934").for(:year) }
    it { should_not allow_value("0", "whenever").for(:year) }
    it { should validate_presence_of :games }
    it { should validate_numericality_of(:games).is_greater_than(0) }
  end
  
  describe "associations" do
    it { should belong_to :team }
    it { should belong_to :player }
  end
end