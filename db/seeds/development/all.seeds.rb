FactoryGirl.create(:user, email: "user@example.com")

puts "Creating organizations and profiles..."

FactoryGirl.create(:organization, :with_profiles)
