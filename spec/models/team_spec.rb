require 'rails_helper'

RSpec.describe Team, :type => :model do
  describe "validations" do
    it { should validate_presence_of :code }
    it { should validate_presence_of :league }
  end
end
