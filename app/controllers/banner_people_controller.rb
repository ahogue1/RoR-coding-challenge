class BannerPeopleController < ApplicationController
  def index
    @banner_people = BannerPerson.all
  end

  def show
    @banner_person = BannerPerson.find(params[:id])
    @handouts = @banner_person.handouts
    @loyalty_points = @banner_person.loyalty_points
    @data = banner_person_monthly_data(Date.today, @banner_person)
  end

  private

  def banner_person_monthly_data(date, banner_person)
    data = []
    days_in_month = date.end_of_month.day

    (1..days_in_month).each do |day|
      date = Date.new(date.year, date.month, day)

      handout = banner_person.handouts.find { |handout| handout.date == date }
      loyalty_point = banner_person.loyalty_points.find do |loyalty_point|
        loyalty_point.date == date
      end

      if handout || loyalty_point
        data.push({
          date: date,
          handout: handout,
          loyalty_point: loyalty_point
        })
      end
    end

    data
  end
end
