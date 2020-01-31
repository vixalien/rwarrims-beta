class AddDepartmentToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :department, :string
    add_column :employees, :head, :boolean
  end
end
