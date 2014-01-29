class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :unique => true
      t.text :description
      t.string :organisation
      t.string :url
      t.string :email
      t.string :active

      t.timestamps
    end
  end
end
