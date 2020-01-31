class CreateLeaves < ActiveRecord::Migration[5.2]
  def change
    create_table :leaves do |t|
      t.text :reason
      t.datetime :start
      t.datetime :end
      t.boolean :approved
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
