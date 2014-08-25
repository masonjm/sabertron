# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    code "MyString"
    born_on "2014-08-25"
    first_name "MyString"
    last_name "MyString"
  end
end
