FactoryGirl.create(:user, email: "user@example.com")

puts "Creating organizations..."

FactoryGirl.create_list(:organization, 5)
