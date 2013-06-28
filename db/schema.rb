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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130410132015) do

  create_table "authors", :force => true do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "search_name"
    t.string   "office"
    t.string   "street"
    t.string   "city"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "url"
    t.text     "cv"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "authorships", :force => true do |t|
    t.integer  "publication_id"
    t.integer  "author_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "authorships", ["author_id"], :name => "index_authorships_on_author_id"
  add_index "authorships", ["publication_id"], :name => "index_authorships_on_publication_id"

  create_table "publications", :force => true do |t|
    t.integer  "type_id"
    t.string   "title"
    t.string   "book_title"
    t.string   "publisher"
    t.string   "published_in"
    t.string   "city"
    t.string   "pages"
    t.integer  "year"
    t.string   "url"
    t.text     "keywords"
    t.text     "abstract"
    t.string   "doi"
    t.string   "edition"
    t.string   "editor"
    t.string   "journal"
    t.string   "volume"
    t.string   "issue"
    t.string   "institution"
    t.date     "date_of_last_access"
    t.string   "type_of_work"
    t.string   "university"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  create_table "types", :force => true do |t|
    t.string   "format"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "login",                  :default => "", :null => false
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
