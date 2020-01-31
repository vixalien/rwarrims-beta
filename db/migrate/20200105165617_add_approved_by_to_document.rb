class AddApprovedByToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :approved_by, :bigint
    add_column :leaves, :approved_by, :bigint
  end
end
