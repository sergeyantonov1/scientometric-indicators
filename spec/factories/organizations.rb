FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
  end

  trait :with_profiles do
    after(:create) do |organization|
      OrganizationProfile::PROFILE_TYPES.each do |profile_type|
        create(:organization_profile,
          profile_type: profile_type,
          organization: organization)
      end
    end
  end
end
