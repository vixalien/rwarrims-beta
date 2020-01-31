class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :country
      t.string :city
      t.inet :ip
      t.string :lat
      t.string :long
      t.string :state
      t.references :loc, polymorphic: true

      t.timestamps
    end
  end
end
