class AddPrecisionToImportCsvs < ActiveRecord::Migration[7.0]
  def change
    change_column :import_csvs, :price, :decimal, precision: 10, scale: 2
  end
end