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

ActiveRecord::Schema[7.0].define(version: 8) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crawl_jobs", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "aasm_state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_crawl_jobs_on_page_id"
  end

  create_table "good_job_batches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.jsonb "serialized_properties"
    t.text "on_finish"
    t.text "on_success"
    t.text "on_discard"
    t.text "callback_queue_name"
    t.integer "callback_priority"
    t.datetime "enqueued_at"
    t.datetime "discarded_at"
    t.datetime "finished_at"
  end

  create_table "good_job_executions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "active_job_id", null: false
    t.text "job_class"
    t.text "queue_name"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.text "error"
    t.integer "error_event", limit: 2
    t.index ["active_job_id", "created_at"], name: "index_good_job_executions_on_active_job_id_and_created_at"
  end

  create_table "good_job_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "state"
  end

  create_table "good_job_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "key"
    t.jsonb "value"
    t.index ["key"], name: "index_good_job_settings_on_key", unique: true
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "queue_name"
    t.integer "priority"
    t.jsonb "serialized_params"
    t.datetime "scheduled_at"
    t.datetime "performed_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "active_job_id"
    t.text "concurrency_key"
    t.text "cron_key"
    t.uuid "retried_good_job_id"
    t.datetime "cron_at"
    t.uuid "batch_id"
    t.uuid "batch_callback_id"
    t.boolean "is_discrete"
    t.integer "executions_count"
    t.text "job_class"
    t.integer "error_event", limit: 2
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["active_job_id"], name: "index_good_jobs_on_active_job_id"
    t.index ["batch_callback_id"], name: "index_good_jobs_on_batch_callback_id", where: "(batch_callback_id IS NOT NULL)"
    t.index ["batch_id"], name: "index_good_jobs_on_batch_id", where: "(batch_id IS NOT NULL)"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at"
    t.index ["cron_key", "cron_at"], name: "index_good_jobs_on_cron_key_and_cron_at", unique: true
    t.index ["finished_at"], name: "index_good_jobs_jobs_on_finished_at", where: "((retried_good_job_id IS NULL) AND (finished_at IS NOT NULL))"
    t.index ["priority", "created_at"], name: "index_good_jobs_jobs_on_priority_created_at_when_unfinished", order: { priority: "DESC NULLS LAST" }, where: "(finished_at IS NULL)"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "hosts", force: :cascade do |t|
    t.bigint "scheme_id", null: false
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scheme_id", "name"], name: "index_hosts_on_scheme_id_and_name", unique: true
    t.index ["scheme_id"], name: "index_hosts_on_scheme_id"
  end

  create_table "page_crawls", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "aasm_state", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_crawls_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "query_id", null: false
    t.string "title", limit: 255
    t.text "content"
    t.text "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_pages_on_content"
    t.index ["query_id"], name: "index_pages_on_query_id"
    t.index ["title"], name: "index_pages_on_title"
  end

  create_table "paths", force: :cascade do |t|
    t.bigint "host_id", null: false
    t.string "value", limit: 1023, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id", "value"], name: "index_paths_on_host_id_and_value", unique: true
    t.index ["host_id"], name: "index_paths_on_host_id"
    t.index ["value"], name: "index_paths_on_value"
  end

  create_table "queries", force: :cascade do |t|
    t.bigint "path_id", null: false
    t.string "value", limit: 1023
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path_id", "value"], name: "index_queries_on_path_id_and_value", unique: true
    t.index ["path_id"], name: "index_queries_on_path_id"
  end

  create_table "schemes", force: :cascade do |t|
    t.string "name", limit: 7, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_schemes_on_name", unique: true
  end

  add_foreign_key "crawl_jobs", "pages"
  add_foreign_key "hosts", "schemes"
  add_foreign_key "page_crawls", "pages"
  add_foreign_key "pages", "queries"
  add_foreign_key "paths", "hosts"
  add_foreign_key "queries", "paths"
end
