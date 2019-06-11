class AddHouseIdToAdvisements < ActiveRecord::Migration[5.1]
  def change
    add_reference :advisements, :house, foreign_key: true
  end
end
