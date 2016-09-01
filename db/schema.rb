# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151015084102) do

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.string   "klass"
    t.string   "url",              default: "/schedule/event"
    t.string   "attachment_title"
    t.string   "attachment_url"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "rendered"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "body"
    t.boolean  "is_announcement", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "rendered"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "body"
    t.boolean  "is_announcement", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "rendered"
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reply_questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "realname"
    t.string   "password"
    t.boolean  "is_admin",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
