class House < ApplicationRecord
  has_many :banner_people
  validates_presence_of :name
end
