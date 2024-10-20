require 'csv'
require "date"

# bin/rails runner import_data.rb　で実行
# rails c は、web bash上でbundle exec rails c

# 1 … CSVファイルのパスを設定する
ACWI_file_path = 'db/csv/ACWI_ETF_Stock_Price_History2.csv' # ルートディレクトリにスクリプトファイルを、db/csvディレクトリにcsvファイルを置いた場合の記述 
SPY_file_path = 'db/csv/SPY_ETF_Stock_Price_History2.csv' #Investing.comでダウンロードしたファイルの内容をコピーしたうえで、新しくファイル作成しコピーした内容を貼り付ける

# 2 … CSVファイルからデータを読み込み、Hogesテーブルに登録
CSV.foreach(ACWI_file_path, headers: true, liberal_parsing: true) do |row|

  ImportCsv.create!(
    product_name: 'ACWI',
    date: row["Date"],
    price: row['Price'].to_f
  )
end

CSV.foreach(SPY_file_path, headers: true, liberal_parsing: true) do |row|

  ImportCsv.create!(
    product_name: 'SPY',
    date: row["Date"],
    price: row['Price'].to_f
  )
end

# 3 … ファイル実行後に、処理が成功したという文章を表示させる。
# ここはお好みで。記述しなくても動作はする。
puts 'CSV data imported successfully!'