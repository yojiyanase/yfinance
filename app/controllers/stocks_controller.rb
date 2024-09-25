# require 'pycall'

class StocksController < ApplicationController
#   def index
#     # Pythonのスクリプトを実行
#     PyCall.py "
# import yfinance as yf
# import pandas as pd

# # 取得したい銘柄
# ticker = 'SPY'

# # 過去10年間の月ごとのデータを取得
# data = yf.download(ticker, period='10y', interval='1mo')

# # PandasのDataFrameをRubyのHashに変換
# data_hash = data.to_dict(orient='index')

# # Rubyの変数に渡す
# data_ruby = data_hash"

#     # 変換されたデータをインスタンス変数に代入
#     @stock_data = PyCall.eval("data_ruby")
#   end


  def index
    # 積立開始日と終了日
    start_date = Date.parse('2017-12-01')
    end_date = Date.parse('2023-12-31')
    monthly_investment = 100

    # 指定期間の株価データを取得
    @stocks = Stock.where(date: start_date..end_date)

    # 積立シミュレーションの実行
    # @monthly_profits = calculate_profits(@stocks, monthly_investment)
    @stock_data = @stocks.pluck(:date, :price)

    # # CSVファイルのパス（適宜変更）
    # csv_path = Rails.root.join('public', 'uploads', 'ACWI ETF Stock Price History.csv')

    # # CSVファイルを読み込み、データを配列に変換
    # CSV.foreach(csv_path, headers: true, quote_char: '"', col_sep: ',', row_sep: "\n", encoding: 'UTF-8', liberal_parsing: true) do |row|
    #   # データをモデルに保存（必要に応じて）
    #   Stock.create(date: row['Date'], price: row['Price'])
    # end

    # # データをビューに渡す
    # @stock_data = CSV.read(csv_path, headers: true, liberal_parsing: true)


    # # 積立シミュレーションのパラメータ
    # start_date = Date.parse('2017-12-01')
    # monthly_investment = 100
    # current_assets = 0
    # purchased_shares = 0

    # # 各月ごとの損益を格納する配列
    # monthly_profits = []

    # @stock_data.each do |row|
    #   date = Date.parse(row['Date'])
    #   price = row['Price'].to_f

    #   # 積立
    #   current_assets += monthly_investment

    #   # ETF購入
    #   while current_assets >= price
    #     purchased_shares += 1
    #     current_assets -= price
    #   end

    #   # 月末の資産額と損益計算
    #   month_end_assets = purchased_shares * price
    #   profit = month_end_assets - current_assets - monthly_investment
    #   monthly_profits << { date: date, profit: profit }

    #   # 次の月の準備
    #   current_assets += purchased_shares * price
    #   purchased_shares = 0
    # end

    # # ビューに渡す
    # @monthly_profits = monthly_profits
  end

  private

  def import
    if params[:csv].present?
      ImportStocksService.new(params[:csv]).call
      redirect_to stocks_path, notice: 'CSVファイルのインポートが完了しました'
    else
      render :new
    end
  end

  def calculate_profits(stocks, monthly_investment)
    # 簡単な例
    # 実際の計算ロジックは、より複雑になる可能性があります
    profits = []
    current_assets = 0
    stocks.each do |stock|
      # 毎月の利益を計算するロジック
      # ...
      profits << { date: stock.date, profit: profit }
    end
    profits
  end
end