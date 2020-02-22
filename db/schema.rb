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

ActiveRecord::Schema.define(version: 2018_12_16_051445) do

  create_table "brand_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "brand_id"
    t.bigint "group_id"
    t.index ["brand_id"], name: "index_brand_groups_on_brand_id"
    t.index ["group_id"], name: "index_brand_groups_on_group_id"
  end

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "initial_word", default: "", null: false
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
  end

  create_table "lower_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "middle_category_id"
    t.index ["middle_category_id"], name: "index_lower_categories_on_middle_category_id"
  end

  create_table "middle_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "upper_category_id"
    t.bigint "size_type_id"
    t.index ["size_type_id"], name: "index_middle_categories_on_size_type_id"
    t.index ["upper_category_id"], name: "index_middle_categories_on_upper_category_id"
  end

  create_table "size_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "size_type", default: "", null: false
  end

  create_table "sizes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "size_type_id"
    t.index ["size_type_id"], name: "index_sizes_on_size_type_id"
  end

  create_table "upper_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
  end

  add_foreign_key "brand_groups", "brands"
  add_foreign_key "brand_groups", "groups"
  add_foreign_key "lower_categories", "middle_categories"
  add_foreign_key "middle_categories", "size_types"
  add_foreign_key "middle_categories", "upper_categories"
  add_foreign_key "sizes", "size_types"
end
