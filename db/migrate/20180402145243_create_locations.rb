class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.text :address, null: false
      t.float :lat, null: false
      t.float :lng, null: false

      t.timestamps
    end
  end
end
