class CreateSp500Data < ActiveRecord::Migration[7.0]
  def change
    create_table :sp500_data do |t|
        t.date :date
        t.float :close
        t.timestamps
    end
  end
end
