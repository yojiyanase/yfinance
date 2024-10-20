# db/migrate/20241019062509_update_import_csvs.rb
class UpdateImportCsvs < ActiveRecord::Migration[7.0]
  def change
    remove_column :import_csvs, :open, :decimal
    remove_column :import_csvs, :high, :decimal
    remove_column :import_csvs, :low, :decimal
    remove_column :import_csvs, :volume, :integer
    remove_column :import_csvs, :change_percentage, :decimal


    add_column :import_csvs, :product_name, :string

    # priceカラムの精度変更は、通常は必要ありません。
    # 既存のデータが新しい精度に収まる場合は、変更する必要はありません。
    # ただし、既存のデータが新しい精度を超える可能性がある場合は、以下のようなマイグレーションを実行する必要があります。
    # change_column :import_csvs, :price, :decimal, precision: 10
  end
end