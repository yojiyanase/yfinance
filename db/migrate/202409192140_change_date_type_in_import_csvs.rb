class ChangeDateTypeInImportCsvs < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        change_column :import_csvs, :date, :date
      end

      direction.down do
        change_column :import_csvs, :date, :integer
      end
    end
  end
end