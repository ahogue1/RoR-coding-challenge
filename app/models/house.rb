class House < ApplicationRecord
  has_many :banner_people, dependent: :destroy
  has_many :handouts, dependent: :destroy
  validates_presence_of :name
end
