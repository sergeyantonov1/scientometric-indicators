FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    scopus_id { Faker::IDNumber.valid }
  end
end