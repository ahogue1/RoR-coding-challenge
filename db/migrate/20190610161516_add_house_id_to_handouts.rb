class AddHouseIdToHandouts < ActiveRecord::Migration[5.1]
  def change
    add_reference :handouts, :house, foreign_key: true
  end
end
