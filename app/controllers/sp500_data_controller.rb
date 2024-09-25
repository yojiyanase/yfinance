# # app/controllers/sp500_data_controller.rb
# require 'open-uri'
# require 'nokogiri'

# class Sp500DataController < ApplicationController
#   def index
#     # Investing.comのページからHTMLを取得
#     url = 'https://www.investing.com/indices/us-spx-500-historical-data'
#     html = URI.open(url).read
#     doc = Nokogiri::HTML(html)

#     # XPathを使って必要なデータを抽出
#     # 実際のXPathはInvesting.comのページの構造に合わせて調整してください
#     data = doc.css('table tbody tr').map do |tr|
#       tds = tr.css('td')
#       { date: tds[0].text, close: tds[1].text.to_f }
#     end

#     # データベースに保存
#     Sp500Datum.create!(data)

#     @sp500_data = Sp500Datum.all
#   end
# end