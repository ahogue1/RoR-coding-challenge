class BannerPeopleController < ApplicationController
  def index
    @banner_people = BannerPerson.all
  end
end
