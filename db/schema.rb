# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_12_104201) do

  create_table "graphs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color", default: "white"
    t.boolean "fill", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.string "field"
    t.index ["number"], name: "index_graphs_on_number"
    t.index ["user_id"], name: "index_graphs_on_user_id"
  end

  create_table "histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "image_data"
    t.integer "number"
    t.integer "percent"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_histories_on_number", unique: true
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "markers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color"
    t.bigint "user_id"
    t.string "field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.index ["color"], name: "index_markers_on_color"
    t.index ["field"], name: "index_markers_on_field"
    t.index ["user_id"], name: "index_markers_on_user_id"
  end

  create_table "months", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "month"
    t.integer "time_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "month"], name: "index_months_on_user_id_and_month", unique: true
    t.index ["user_id"], name: "index_months_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "studies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "count"
    t.string "date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content_today"
    t.boolean "value", default: false, null: false
    t.index ["user_id", "date"], name: "index_studies_on_user_id_and_date", unique: true
    t.index ["user_id"], name: "index_studies_on_user_id"
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.boolean "complete", default: false
    t.bigint "study_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_id"], name: "index_tasks_on_study_id"
  end

  create_table "time_by_field_todays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "count"
    t.bigint "time_by_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["time_by_field_id"], name: "index_time_by_field_todays_on_time_by_field_id"
  end

  create_table "time_by_fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color"
    t.integer "count"
    t.string "field"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field"], name: "index_time_by_fields_on_field"
    t.index ["user_id"], name: "index_time_by_fields_on_user_id"
  end

  create_table "timers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "start_time"
    t.integer "time_to_calculate"
    t.string "color"
    t.string "stop_time"
    t.integer "stopped_time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_timers_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.text "description"
    t.integer "num_graph"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "graphs", "users"
  add_foreign_key "histories", "users"
  add_foreign_key "markers", "users"
  add_foreign_key "months", "users"
  add_foreign_key "studies", "users"
  add_foreign_key "tasks", "studies"
  add_foreign_key "time_by_field_todays", "time_by_fields"
  add_foreign_key "time_by_fields", "users"
  add_foreign_key "timers", "users"
end
