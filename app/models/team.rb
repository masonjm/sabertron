class Team < ActiveRecord::Base
  validates :code, :league, presence: true
  
  def to_s
    code
  end
end
