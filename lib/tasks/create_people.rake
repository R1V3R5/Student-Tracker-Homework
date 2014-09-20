task create_people: :environment do
  50.times do |people|
    Player.create( {name: "#{Faker::Name.first_name} #{Faker::Name.last_name}", phone_number: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip, email: Faker::Internet.email  } )
  end
end