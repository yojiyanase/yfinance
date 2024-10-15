class CreateSimulations < ActiveRecord::Migration[7.0]
  def change
    create_table :simulations do |t|
      t.string :index_fund
      t.integer :monthly_amount
      t.integer :start_year
      t.integer :start_month
      t.integer :end_year
      t.integer :end_month

      t.timestamps
    end
  end
end
