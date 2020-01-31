class AddExpectedToLeaves < ActiveRecord::Migration[5.2]
  def change
    add_column :leaves, :expected, :datetime
    add_column :employees, :leave_balance, :integer
  end
end
