# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    sequence(:code) {|n| n.to_s}
    birth_year "1904"
    first_name "Test"
    last_name "Player"
  end
end
