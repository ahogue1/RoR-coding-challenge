puts "Emptying Database..."

House.destroy_all

puts "-------------------------------------------"
puts "Creating Seeds..."
puts "-------------------------------------------"

### Generate 4 random Houses
houses = []

4.times do
  name = Faker::TvShows::GameOfThrones.unique.house
  house = House.create(name: name, prefix: name.scan(/\b[a-zA-Z]/).join.upcase)
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


    loyalty_point_days = [rand(1..7), rand(8..15), rand(16..23), rand(24..31)] # Generate 1 random date each week
    handout_days = (1..31).to_a.shuffle.take(rand(8..12)) # Generate 8 to 12 unique random dates
    advisement_days = handout_days.shuffle.take(3) # Generate Handouts: 2 to 3 handouts per week
    acceptance_odds = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] + (-5..5).to_a #Odds of accepting the last advisement is 50% or might increase or decrease
    advisement = nil

    (1..31).each do |day|
      ### Generate Loyalty points about once/week
      date = Date.new(2019, 1, day)
      if loyalty_point_days.include? day

        points = LoyaltyPoint.create(
          banner_person: banner_person,
          value: rand(5.0..18.0).round(1),
          date: date
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

      ### Generate Advisement points every couple of weeks
      if advisement_days.include? day
        advisement = Advisement.create(
          banner_person: banner_person,
          value: rand(2..200) * 100,
          date: date,
          house: banner_person.house
        )
      end

      if handout_days.include? day
        if rand(1..10) > 1 # Skip 10% of handouts
          if advisement
            value = advisement.value
          else
            value = rand(2..200) * 100
          end

          #decides if handout should increase, decrease or maintain
          recommendation = value + (acceptance_odds.sample * 100)

          Handout.create(
            banner_person: banner_person,
            value: recommendation,
            date: date,
            house: banner_person.house
          )
        end
      end
    end
  end
end

puts "-------------------------------------------"
puts "Finished - #{Faker::TvShows::GameOfThrones.quote}"
puts "-------------------------------------------"
