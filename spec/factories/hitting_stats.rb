# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hitting_stat do
    player nil
    team nil
    year "2014"
    games 1
    at_bats 1
    runs 1
    singles 1
    doubles 1
    triples 1
    home_runs 1
    rbi 1
    stolen_bases 1
    caught_stealing 1
  end
end
