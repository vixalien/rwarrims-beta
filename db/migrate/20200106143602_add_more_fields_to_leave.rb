class AddMoreFieldsToLeave < ActiveRecord::Migration[5.2]
  def change
    add_column :leaves, :category, :string
    add_column :leaves, :recommended, :boolean
    add_column :leaves, :date_recommended, :datetime
    add_column :leaves, :date_approved, :datetime
    add_column :leaves, :recommended_by, :bigint
  end
end
