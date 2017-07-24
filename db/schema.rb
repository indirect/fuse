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

ActiveRecord::Schema.define(version: 20170724072547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "installations", force: :cascade do |t|
    t.bigint "github_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.datetime "access_token_expires_at"
    t.index ["github_id"], name: "index_installations_on_github_id", unique: true
  end

  create_table "repositories", force: :cascade do |t|
    t.bigint "installation_id"
    t.bigint "github_id"
    t.string "full_name"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_name"], name: "index_repositories_on_full_name"
    t.index ["github_id"], name: "index_repositories_on_github_id"
    t.index ["installation_id"], name: "index_repositories_on_installation_id"
  end

  create_table "test_builds", force: :cascade do |t|
    t.string "sha"
    t.bigint "issue_number"
    t.bigint "comment_id"
    t.bigint "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_test_builds_on_repository_id"
    t.index ["sha"], name: "index_test_builds_on_sha"
  end

  add_foreign_key "repositories", "installations"
  add_foreign_key "test_builds", "repositories"
end
