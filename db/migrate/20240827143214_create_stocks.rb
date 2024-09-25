class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.date :date
      t.decimal :price

      t.timestamps
    end
  end
end
