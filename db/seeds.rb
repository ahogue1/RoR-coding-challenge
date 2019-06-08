puts "Emptying Database..."

House.destroy_all

puts "Creating Seeds..."

4.times do
  house = House.create(name: Faker::TvShows::GameOfThrones.unique.house)

  puts "Creating '#{house.name}' House..."

  2.times do
    banner_person = BannerPerson.create(
      name: Faker::TvShows::GameOfThrones.unique.character,
      house: house
    )

    # Generate 8 to 12 (2 to 3 times per week) unique random dates
    random_days = (1..30).to_a.shuffle.take(rand(8..12))
    random_days.each do |day|
      # Skip 10% of handouts
      if rand(1..10) > 1
        Handout.create(
          banner_person: banner_person,
          value: rand(2..200) * 100,
          date: Date.new(2019, 6, day)
        )
      end
    end

    # Generate 4 random almost weekly dates
    random_days = [rand(1..7), rand(8..14), rand(15..22), rand(23..30)]
    random_days.each do |day|
      LoyaltyPoint.create(
        banner_person: banner_person,
        value: rand(5.0..18.0).round(1),
        date: Date.new(2019, 6, day)
      )
    end
  end
end

puts "Seeds Created"
