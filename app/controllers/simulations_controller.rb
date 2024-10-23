# app/controllers/simulations_controller.rb
class SimulationsController < ApplicationController
  def input_form
    @simulation = Simulation.new  # フォームオブジェクトのインスタンス化

    @latest_sp500_date = latest_date_by_product('S&P500 (SPY)')
    @latest_acwi_date = latest_date_by_product('全世界株式 (ACWI)')
  end

  def calculate
    @simulation = Simulation.new(simulation_params)  # フォームパラメータの取得
    # 計算処理の実行
    # CSVデータとの突合処理の実行

    start_date = Date.new(@simulation.start_year, @simulation.start_month)
    end_date = Date.new(@simulation.end_year, @simulation.end_month)

    @matching_data = ImportCsv.where(product_name: @simulation.index_fund)
                              .where("date >= ?", start_date)
                              .where("date <= ?", end_date)
                              .pluck(:date, :price, :product_name)

    total_amount = @simulation.monthly_amount.to_i * 12 * (@simulation.end_year.to_i - @simulation.start_year.to_i)

    # セッションに保存
    session[:simulation] = @simulation.attributes
    session[:result] = { total_amount: total_amount }
    session[:matching_data] = @matching_data
    # @matching_data = @matching_data.attributes

    # render 'simulations/result' # 計算結果を表示するビューを指定
    # redirect_to 'http://localhost:3000/simulations/result' # 計算結果を表示するビューを指定
    redirect_to simulations_result_path
  end

  def result
    @simulation = Simulation.new(session[:simulation])
    @result = session[:result]
    @matching_datas = session[:matching_data]
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
end