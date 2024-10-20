# app/controllers/simulations_controller.rb
class SimulationsController < ApplicationController
  def input_form
    @simulation = Simulation.new  # フォームオブジェクトのインスタンス化
  end

  def calculate
    @simulation = Simulation.new(simulation_params)  # フォームパラメータの取得
    # 計算処理の実行
    # CSVデータとの突合処理の実行

    total_amount = @simulation.monthly_amount.to_i * 12 * (@simulation.end_year.to_i - @simulation.start_year.to_i)

    # セッションに保存
    session[:simulation] = @simulation.attributes
    session[:result] = { total_amount: total_amount }

    # render 'simulations/result' # 計算結果を表示するビューを指定
    # redirect_to 'http://localhost:3000/simulations/result' # 計算結果を表示するビューを指定
    redirect_to simulations_result_path
  end

  def result
    @simulation = Simulation.new(session[:simulation])
    @result = session[:result]
  end

  private

  def simulation_params
    params.require(:simulation).permit(:index_fund, :monthly_amount, :start_year, :start_month, :end_year, :end_month)
  end
end