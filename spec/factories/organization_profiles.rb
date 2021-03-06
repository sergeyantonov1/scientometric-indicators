FactoryGirl.define do
  factory :organization_profile do
    profile_type { Enumeration::CITATIONS_DATABASES.first }
    profile_id { Faker::IDNumber.valid }
    organization
  end
end
