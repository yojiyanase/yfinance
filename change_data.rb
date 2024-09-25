require 'csv'

csv_file_path = 'db/csv/ACWI_ETF_Stock_Price_History.csv'

CSV.foreach(csv_file_path, headers: true, quote_char: "'", col_sep: ',', row_sep: "\n", encoding: 'UTF-8') do |row|
  begin
    date_str = row['Date']
    date_obj = Date.strptime(date_str, '%m/%d/%Y')

    ImportCsvs.create!(
      date: date_obj,
      price: row['Price'].to_f,
      open: row['Open'].to_f,
      high: row['High'].to_f,
      low: row['Low'].to_f,
      volume: row['Vol.'].gsub('M', '').to_i * 1000000,
      change_percentage: row['Change %'].gsub('%', '').to_f / 100
    )
  rescue ArgumentError => e
    puts "Invalid date format: #{date_str}"
    next  # またはエラー処理
  end
end