require 'csv'
require "date"

# 1 … CSVファイルのパスを設定する
csv_file_path = 'db/csv/ACWI_ETF_Stock_Price_History.csv' # ルートディレクトリにスクリプトファイルを、db/csvディレクトリにcsvファイルを置いた場合の記述 
csv_file_path = 'db/csv/ACWI_ETF_Stock_Price_History2.csv' #Investing.comでダウンロードしたファイルの内容をコピーしたうえで、新しくファイル作成しコピーした内容を貼り付ける

# 2 … CSVファイルからデータを読み込み、Hogesテーブルに登録
CSV.foreach(csv_file_path, headers: true, liberal_parsing: true) do |row|

  ImportCsv.create!(
    date: row["Date"],
    price: row['Price'].to_f,
    open: row['Open'].to_f,
    high: row['High'].to_f,
    low: row['Low'].to_f,
    volume: row['Vol.'].gsub('M', '').to_i * 1000000,
    change_percentage: row['Change %'].gsub('%', '').to_f / 100
  )
end

# 3 … ファイル実行後に、処理が成功したという文章を表示させる。
# ここはお好みで。記述しなくても動作はする。
puts 'CSV data imported successfully!'