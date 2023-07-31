class AddAttributesToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :name, :string
    add_column :employees, :emp_id, :string
    add_column :employees, :dept, :string
    add_column :employees, :emp_status, :string
  end
end
