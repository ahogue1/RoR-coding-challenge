class LoyaltyPoint < ApplicationRecord
  belongs_to :banner_person
  validates_presence_of :date, :value
  validates :value, numericality: { greater_than_or_equal_to: 5.0,  less_than_or_equal_to: 18.0 }
end
