# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_09_17_120000) do
  create_table "import_csvs", force: :cascade do |t|
    t.date "date"
    t.decimal "price", precision: 10, scale: 2
    t.decimal "open", precision: 10, scale: 2
    t.decimal "high", precision: 10, scale: 2
    t.decimal "low", precision: 10, scale: 2
    t.integer "volume"
    t.decimal "change_percentage", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sp500_data", force: :cascade do |t|
    t.date "date"
    t.float "close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.date "date"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
