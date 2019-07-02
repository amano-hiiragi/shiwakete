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

ActiveRecord::Schema.define(version: 20190702052118) do

  create_table "characters", force: :cascade do |t|
    t.string "character_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_name"], name: "index_characters_on_character_name", unique: true
  end

  create_table "image_characters", force: :cascade do |t|
    t.integer "image_id"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_image_characters_on_character_id"
    t.index ["image_id"], name: "index_image_characters_on_image_id"
    t.index [nil, nil], name: "index_image_characters_on_image_and_character", unique: true
    t.index [nil], name: "index_image_characters_on_character"
    t.index [nil], name: "index_image_characters_on_image"
  end

  create_table "image_titles", force: :cascade do |t|
    t.integer "image_id"
    t.integer "title_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_image_titles_on_image_id"
    t.index ["title_id"], name: "index_image_titles_on_title_id"
    t.index [nil, nil], name: "index_image_titles_on_image_and_title", unique: true
    t.index [nil], name: "index_image_titles_on_image"
    t.index [nil], name: "index_image_titles_on_title"
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_images_on_url", unique: true
  end

  create_table "titles", force: :cascade do |t|
    t.string "title_of_work"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title_of_work"], name: "index_titles_on_title_of_work", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
