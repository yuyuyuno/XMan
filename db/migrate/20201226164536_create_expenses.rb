class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.float :amount
      t.string :comment
      t.datetime :expense_time

      t.timestamps
    end
  end
end
