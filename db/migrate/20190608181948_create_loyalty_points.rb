class CreateLoyaltyPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :loyalty_points do |t|
      t.date :date
      t.float :value
      t.references :banner_person, foreign_key: true

      t.timestamps
    end
  end
end
