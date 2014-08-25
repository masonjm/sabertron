# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    sequence :code
    born_on "2014-08-25"
    first_name "Test"
    last_name "Player"
  end
end
