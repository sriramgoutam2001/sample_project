class AddAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :emp_id, :string
    add_column :users, :department, :string
    add_column :users, :status, :string
  end
end
