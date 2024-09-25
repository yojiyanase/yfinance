# db/migrate/YYYYMMDD000000_change_date_to_integer.rb
class ChangeDateToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :import_csvs, :date, :integer
  end
end