# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hitting_stat do
    association :player
    association :team
    year 2014
    games 1
    at_bats 0
    runs 0
    singles 0
    doubles 0
    triples 0
    home_runs 0
    rbi 0
    stolen_bases 0
    caught_stealing 0
  end
end
