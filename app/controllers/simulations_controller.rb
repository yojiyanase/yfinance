# app/controllers/simulations_controller.rb
class SimulationsController < ApplicationController
  def input_form
    if session[:simulation]
      @simulation = Simulation.new(session[:simulation])
    else
      @simulation = Simulation.new  # フォームオブジェクトのインスタンス化
    end
    
    @latest_sp500_date = latest_date_by_product('S&P500 (SPY)')
    @latest_acwi_date = latest_date_by_product('全世界株式 (ACWI)')
  end

  def calculate
    @latest_sp500_date = latest_date_by_product('S&P500 (SPY)')
    @latest_acwi_date = latest_date_by_product('全世界株式 (ACWI)')

    @simulation = Simulation.new(simulation_params)  # フォームパラメータの取得
    # 計算処理の実行
    # CSVデータとの突合処理の実行
    respond_to do |format|
      if  @simulation.valid?

      start_date = Date.new(@simulation.start_year, @simulation.start_month)
      end_date = Date.new(@simulation.end_year, @simulation.end_month)

      @matching_data = ImportCsv.where(product_name: @simulation.index_fund)
                                .where("date >= ?", start_date)
                                .where("date <= ?", end_date)
                                .order(date: :asc)
                                .pluck(:date, :price, :product_name)

      total_amount = @simulation.monthly_amount.to_i * 12 * (@simulation.end_year.to_i - @simulation.start_year.to_i)

      stock_prices = @matching_data.map { |data| data[1] }
      @total_assets = calculate_assets(@simulation.monthly_amount, stock_prices)

      # セッションに保存
      session[:simulation] = @simulation.attributes
      session[:result] = { total_amount: total_amount }
      session[:matching_data] = @matching_data
      session[:total_assets] = @total_assets
      # @matching_data = @matching_data.attributes

      # render 'simulations/result' # 計算結果を表示するビューを指定
      # redirect_to 'http://localhost:3000/simulations/result' # 計算結果を表示するビューを指定
    
        format.html { redirect_to simulations_result_path }
        format.json { render :result, status: :created, location: @simulation }
      else
        flash.now[:danger] = t('.failure')
        format.html { render :input_form, status: :unprocessable_entity }
        format.json { render json: @simulation.errors, status: :unprocessable_entity }
      end
    end
  end

  def result
    @simulation = Simulation.new(session[:simulation])
    @result = session[:result]
    @matching_datas = session[:matching_data]
    @total_assets = session[:total_assets]
  end

  private

  def simulation_params
    params.require(:simulation).permit(:index_fund, :monthly_amount, :start_year, :start_month, :end_year, :end_month)
  end

  def latest_date_by_product(product_name)
    # ImportCsvモデルから、指定したproduct_nameのデータのうち、
    # dateが最新のレコードのdateを取得
    ImportCsv.where(product_name: product_name).order(date: :desc).first&.date
  end

  def calculate_assets(monthly_amount, prices)
    balance = 0  # 残高の初期化
    buy_count = 0
    rest_money = 0
    total_assets = []
    prices.each do |price|
      if monthly_amount >= price
        buy_count += (monthly_amount / price).to_i
        rest_money += monthly_amount % price
        total_assets.push(price * buy_count + rest_money)
      else
        if monthly_amount + rest_money >= price
          buy_count += ((monthly_amount + rest_money) / price).to_i
          rest_money = monthly_amount + rest_money - price
          total_assets.push(price * buy_count + rest_money)
        else
          buy_count = buy_count.to_i
          rest_money += monthly_amount
          total_assets.push(price * buy_count + rest_money)
        end
      end
    end
    total_assets
  end
end