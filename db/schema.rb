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

ActiveRecord::Schema.define(version: 20160713085659) do

  create_table "activities", force: :cascade do |t|
    t.string   "action_type"
    t.integer  "target_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "course_subjects", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_subjects", ["course_id"], name: "index_course_subjects_on_course_id"
  add_index "course_subjects", ["subject_id"], name: "index_course_subjects_on_subject_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["subject_id"], name: "index_tasks_on_subject_id"

  create_table "user_courses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id"
  add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id"

  create_table "user_subjects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "user_course_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "user_subjects", ["subject_id"], name: "index_user_subjects_on_subject_id"
  add_index "user_subjects", ["user_course_id"], name: "index_user_subjects_on_user_course_id"
  add_index "user_subjects", ["user_id"], name: "index_user_subjects_on_user_id"

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id"
  add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "birthday"
    t.integer  "gender"
    t.string   "password_digest"
    t.boolean  "supervisor"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
