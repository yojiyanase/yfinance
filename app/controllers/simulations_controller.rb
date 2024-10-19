# app/controllers/simulations_controller.rb
class SimulationsController < ApplicationController
  def input_form
    @simulation = Simulation.new  # フォームオブジェクトのインスタンス化
  end

  def calculate
    @simulation = Simulation.new(simulation_params)  # フォームパラメータの取得
    # 計算処理の実行
    # CSVデータとの突合処理の実行

    # 計算結果をビューに渡す
    @result = {
      # 計算結果をハッシュ形式で格納
      # total_amount: total_amount,
      # annualized_return: annualized_return,
    }

    render 'simulations/result' # 計算結果を表示するビューを指定
    # redirect_to 'http://localhost:3000/simulations/result' # 計算結果を表示するビューを指定

  end

  def result 

  end

  private

  def simulation_params
    params.require(:simulation).permit(:index_fund, :monthly_amount, :start_year, :start_month, :end_year, :end_month)
  end
end