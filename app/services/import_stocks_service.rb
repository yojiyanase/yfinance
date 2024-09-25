# app/services/import_stocks_service.rb
# class ImportStocksService
#   def initialize(csv_file)
#     @csv_file = csv_file
#   end

#   def call
#     CSV.foreach(@csv_file, headers: true, force_quotes: true, liberal_parsing: true) do |row|
#       # Dateをパースして型変換
#       parsed_date = Date.parse(row['Date'])
#       Stock.create!(date: parsed_date, price: row['Price'])
#     rescue StandardError => e
#       # エラー処理 (ログ出力、通知など)
#       Rails.logger.error "CSV import failed: #{e.message}"
#     end
#   end
# end
