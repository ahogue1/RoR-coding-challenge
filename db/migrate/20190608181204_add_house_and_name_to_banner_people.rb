class AddHouseAndNameToBannerPeople < ActiveRecord::Migration[5.1]
  def change
    add_reference :banner_people, :house, foreign_key: true
    add_column :banner_people, :name, :string
  end
end
