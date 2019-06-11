class BannerPeopleController < ApplicationController
  def index
    @banner_people = BannerPerson.all
  end

  def show
    @banner_person = BannerPerson.find(params[:id])
    @handouts = @banner_person.handouts
    @loyalty_points = @banner_person.loyalty_points
    @graph_data = graph_data( @banner_person)
    @table_data = table_data(@banner_person.advisements, @graph_data)

    gon.dates = @graph_data.map { |datum| datum[:date].strftime("%b %d") }
    gon.handouts = @graph_data.map { |datum|
      datum[:handout] ? datum[:handout].value : nil
    }
    gon.loyalty_points = @graph_data.map.with_index { |datum, index|
      datum[:loyalty_point] ? [index, datum[:loyalty_point].value] : nil
    }.compact
  end

  private

  def graph_data(banner_person)
    graph_data = []
    house = banner_person.handouts.first.house

    (1..31).each do |day|
      date = Date.new(2019, 1, day)


      handout = banner_person.handouts.find { |handout| handout.date == date }
      loyalty_point = banner_person.loyalty_points.find do |loyalty_point|
        loyalty_point.date == date
      end

      if handout
          house = handout.house
          house.save
      end

      if handout || loyalty_point
        graph_data.push({
          date: date,
          handout: handout,
          loyalty_point: loyalty_point,
          house: house
        })
      end
    end

    graph_data
  end

  def table_data(advisements, graph_data)
    table_data = graph_data.deep_dup

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
    end

    table_data.sort { |a, b| a[:date] <=> b[:date] }
  end
end
