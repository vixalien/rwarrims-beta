class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :state
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
