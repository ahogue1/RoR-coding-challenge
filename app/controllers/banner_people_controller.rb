class BannerPeopleController < ApplicationController
  include BannerPersonStatistics

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

end
