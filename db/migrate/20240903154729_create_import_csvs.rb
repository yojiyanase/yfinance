class CreateImportCsvs < ActiveRecord::Migration[7.0]
  def change
    create_table :import_csvs do |t|
      t.date :date
      t.decimal :price, precision: 10, scale: 2
      t.decimal :open, precision: 10, scale: 2
      t.decimal :high, precision: 10, scale: 2
      t.decimal :low, precision: 10, scale: 2
      t.integer :volume
      t.decimal :change_percentage, precision: 5, scale: 2
      t.timestamps
    end
  end
end
