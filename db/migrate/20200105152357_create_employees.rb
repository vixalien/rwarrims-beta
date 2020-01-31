class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :names
      t.string :email
      t.string :idcard
      t.string :password
      t.boolean :admin
      t.string :position
      t.references :approver, polymorphic: true

      t.timestamps
    end
  end
end
