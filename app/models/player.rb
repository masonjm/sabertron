class Player < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  
  def to_s
    "#{first_name} #{last_name}"
  end
end
