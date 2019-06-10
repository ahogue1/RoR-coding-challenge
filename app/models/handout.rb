class Handout < ApplicationRecord
  belongs_to :banner_person
  belongs_to :house
  validates_presence_of :date, :value
  validates :value, numericality: { greater_than_or_equal_to: 200,  less_than_or_equal_to: 20_000 }
  validate :value_must_be_divisible_by_100

  def value_must_be_divisible_by_100
    if value.present? && value % 100 != 0
      errors.add(:value, "must be divisible by 100")
    end
  end
end
