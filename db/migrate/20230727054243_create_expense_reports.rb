class CreateExpenseReports < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_reports do |t|
      t.string :name
      t.text :description
      t.decimal :total_amount

      t.timestamps
    end
  end
end
