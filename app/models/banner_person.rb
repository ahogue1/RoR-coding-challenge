class BannerPerson < ApplicationRecord
  belongs_to :house
  has_many :handouts
  has_many :loyalty_points
end
