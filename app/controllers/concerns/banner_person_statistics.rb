module BannerPersonStatistics
  extend ActiveSupport::Concern

  def graph_data(banner_person)
    graph_data = []
    house = banner_person.handouts.first.house

    (1..31).each do |day|
      date = Date.new(2019, 1, day)


      handout = banner_person.handouts.find { |handout| handout.date == date }
      loyalty_point = banner_person.loyalty_points.find do |loyalty_point|
        loyalty_point.date == date
      end

      house = handout.house if handout

      if handout || loyalty_point
        graph_data.push({
          date: date,
          handout: handout,
          loyalty_point: loyalty_point,
          house: house
        })
      else
        graph_data.push({
          date: date
        })
      end
    end

    graph_data
  end

  def table_data(advisements, graph_data)
    table_data = graph_data.select { |datum| datum[:handout] || datum[:loyalty_point] }.deep_dup
    previous_advisement = nil

    advisements.each do |advisement|
      datum = table_data.find { |datum| datum[:date] == advisement.date }

      if datum
        datum[:advisement] = advisement
      else
        table_data.push({
          date: advisement.date,
          advisement: advisement,
          house: advisement.house,
        })
      end

      if previous_advisement
        find_percent_accepted(table_data, previous_advisement, advisement.date)
      end

      previous_advisement = advisement
    end

    end_date = table_data.last[:date] + 1.day
    find_percent_accepted(table_data, previous_advisement, end_date)

    table_data.sort { |a, b| a[:date] <=> b[:date] }
  end

  def find_percent_accepted(table_data, advisement, end_date)
    data_between_advisements = table_data.select { |datum|
      datum[:date] >= advisement.date && datum[:date] < end_date
    }

    handouts = data_between_advisements.map { |datum| datum[:handout] }.compact

    # calculate acceptance percentage
    percentage = calculate_percentage(handouts, advisement)

    data_between_advisements.each { |datum_between_advisements|
      datum_between_advisements[:percent_accepted] = percentage
    }
  end

  def calculate_percentage(handouts, previous_advisement)
    matching = handouts.count { |handout| handout.value == previous_advisement.value }
    decimal = matching / handouts.count.to_f
    (decimal * 100).round(1)
  end
end
