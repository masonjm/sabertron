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

ActiveRecord::Schema.define(version: 20140825144551) do

  create_table "hitting_stats", force: true do |t|
    t.integer  "player_id",                   null: false
    t.integer  "team_id",                     null: false
    t.string   "year",                        null: false
    t.integer  "games",                       null: false
    t.integer  "at_bats",         default: 0
    t.integer  "runs",            default: 0
    t.integer  "singles",         default: 0
    t.integer  "doubles",         default: 0
    t.integer  "triples",         default: 0
    t.integer  "home_runs",       default: 0
    t.integer  "rbi",             default: 0
    t.integer  "stolen_bases",    default: 0
    t.integer  "caught_stealing", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hitting_stats", ["player_id"], name: "index_hitting_stats_on_player_id"
  add_index "hitting_stats", ["team_id"], name: "index_hitting_stats_on_team_id"

  create_table "players", force: true do |t|
    t.string   "code"
    t.date     "born_on"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "code"
    t.string   "league"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
