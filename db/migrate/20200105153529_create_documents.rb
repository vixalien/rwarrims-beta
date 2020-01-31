class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.boolean :approved
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
