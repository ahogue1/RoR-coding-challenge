class DropBannerPersons < ActiveRecord::Migration[5.1]
  def change
    drop_table :banner_persons
  end
end
