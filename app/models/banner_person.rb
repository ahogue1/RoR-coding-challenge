class BannerPerson < ApplicationRecord
  belongs_to :house
  has_many :handouts, dependent: :destroy
  has_many :loyalty_points, dependent: :destroy
  validates_presence_of :name
end
