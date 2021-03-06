FactoryGirl.define do
  factory :author_profile do
    profile_type { Enumeration::CITATIONS_DATABASES.first }
    profile_id { Faker::IDNumber.valid }
    author
    h_index { 0 }
  end
end
