class House < ApplicationRecord
  has_many :banner_people, dependent: :destroy
  validates_presence_of :name
end
