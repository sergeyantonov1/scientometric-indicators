FactoryGirl.define do
  factory :organization_profile do
    profile_type { OrganizationProfile::PROFILE_TYPES.first }
    profile_id { Faker::IDNumber.valid }
    organization
  end
end
