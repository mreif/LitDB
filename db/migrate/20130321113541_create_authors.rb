class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :search_name
      t.string :office
      t.string :street
      t.string :city
      t.string :zip_code
      t.string :phone
      t.string :url
      t.text   :cv

      t.timestamps
    end
  end
end
