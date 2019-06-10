class CreateAdvisements < ActiveRecord::Migration[5.1]
  def change
    create_table :advisements do |t|
      t.date :date
      t.integer :value
      t.references :banner_person, foreign_key: true

      t.timestamps
    end
  end
end
