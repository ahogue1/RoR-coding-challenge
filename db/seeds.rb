puts "Emptying Database..."

House.destroy_all

puts "-------------------------------------------"
puts "Creating Seeds..."
puts "-------------------------------------------"


### Generate 4 random Houses
4.times do
  house = House.create(name: Faker::TvShows::GameOfThrones.unique.house)

  puts "Creating '#{house.name}' House..."

  ### Generate 2 banner people per house
  2.times do
    banner_person = BannerPerson.create(
      name: Faker::TvShows::GameOfThrones.unique.character,
      house: house
    )

    ### Generate Handouts: 2 to 3 handouts per week, reject 10%
    random_days = (1..30).to_a.shuffle.take(rand(8..12)) # Generate 8 to 12 unique random dates
    random_days.each do |day|
      if rand(1..10) > 1 # Skip 10% of handouts
        Handout.create(
          banner_person: banner_person,
          value: rand(2..200) * 100,
          date: Date.new(2019, 6, day)
        )
      end
    end

    ### Generate Loyalty points about once/week
    random_days = [rand(1..7), rand(8..14), rand(15..22), rand(23..30)] # Generate 4 random dates each week
    random_days.each do |day|
      LoyaltyPoint.create(
        banner_person: banner_person,
        value: rand(5.0..18.0).round(1),
        date: Date.new(2019, 6, day)
      )
    end
  end
end

puts "-------------------------------------------"
puts "Seeds Created, calculating house changes..."
puts "-------------------------------------------"

### Reassign Houses for low loyalty points
houses = House.all.to_a
low_loyalties = LoyaltyPoint.where("value < 10")

low_loyalties.each do |loyalty|
  banner_person = loyalty.banner_person
  old_house = banner_person.house
  new_house = houses.sample

  if new_house == old_house
    puts "#{banner_person.name}'s Loyalty Points dropped too low, but will remain in House #{new_house.name}"
  else
    banner_person.house = new_house
    banner_person.save
    puts "#{banner_person.name}'s Loyalty Points dropped too low and has switched from House #{old_house.name} to House #{new_house.name}"
  end
end

puts "-------------------------------------------"
puts "Finished - #{Faker::TvShows::GameOfThrones.quote}"
puts "-------------------------------------------"
