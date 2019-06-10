puts "Emptying Database..."

House.destroy_all

puts "-------------------------------------------"
puts "Creating Seeds..."
puts "-------------------------------------------"


### Generate 4 random Houses
houses = []

4.times do
  house = House.create(name: Faker::TvShows::GameOfThrones.unique.house)
  houses << house

  puts "Created House '#{house.name}'"
end

puts "-------------------------------------------"
puts "Houses Created, populating houses and collecting Banner People data..."
puts "-------------------------------------------"

### Generate 2 banner people per house
houses.each do |house|
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
      points = LoyaltyPoint.create(
        banner_person: banner_person,
        value: rand(5.0..18.0).round(1),
        date: Date.new(2019, 6, day)
      )

      #Check for low loyalty points and generate house change if loyalty points fall below 10
      if points.value < 10
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
    end

    ### Generate Loyalty points every couple of weeks
    random_days = [rand(1..15), rand(15..30)] # Generate 2 random advisement dates per month
    random_days.each do |day|
      Advisement.create(
        banner_person: banner_person,
        value: rand(2..200) * 100,
        date: Date.new(2019, 6, day)
      )
    end
  end
end

puts "-------------------------------------------"
puts "Finished - #{Faker::TvShows::GameOfThrones.quote}"
puts "-------------------------------------------"
