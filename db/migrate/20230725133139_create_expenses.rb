class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.date :date
      t.string :description
      t.string :invoice_number

      t.timestamps
    end
  end
end
