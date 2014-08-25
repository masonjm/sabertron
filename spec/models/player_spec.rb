require 'rails_helper'

RSpec.describe Player, :type => :model do
  describe "validations" do
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of :code }
  end
end
