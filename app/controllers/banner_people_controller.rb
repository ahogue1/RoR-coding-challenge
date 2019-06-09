class BannerPeopleController < ApplicationController
  def index
    @banner_people = BannerPerson.all
  end

  def show
    @banner_person = BannerPerson.find(params[:id])
    @handouts = @banner_person.handouts
    @loyalty_points = @banner_person.loyalty_points
    @date = Date.today
  end
end
