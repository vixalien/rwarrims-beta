class CreateUseragents < ActiveRecord::Migration[5.2]
  def change
    create_table :useragents do |t|
      t.string :full
      t.string :browser
      t.string :os
      t.references :ua, polymorphic: true

      t.timestamps
    end
  end
end
