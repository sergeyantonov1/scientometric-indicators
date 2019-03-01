FactoryGirl.define do
  factory :author do
    first_name { Faker::Name.first_name }
    second_name { Faker::Name.last_name }
    organization

    trait :with_profiles do
      after(:create) do |author|
        Enumeration::CITATIONS_DATABASES.each do |profile_type|
          create(:author_profile,
            profile_type: profile_type,
            author: author)
        end
      end
    end
  end
end
