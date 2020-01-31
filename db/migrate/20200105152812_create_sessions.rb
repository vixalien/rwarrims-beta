class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :state
      t.text :cookie
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
