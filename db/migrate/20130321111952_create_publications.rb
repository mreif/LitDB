class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.belongs_to :type
      t.string :title
      t.string :book_title
      t.string :publisher
      t.string :published_in
      t.string :city
      t.string :pages
      t.integer :year
      t.string :url
      t.text :keywords
      t.text :abstract
      t.string :doi
      t.string :edition
      t.string :editor
      t.string :journal
      t.string :volume
      t.string :issue
      t.string :institution
      t.date :date_of_last_access
      t.string :type_of_work
      t.string :university

      t.timestamps
    end
  end
  
  def self.up
    create_table :publications do |t|
      t.belongs_to :type
      t.string :title
      t.string :book_title
      t.string :publisher
      T.string :published_in
      t.string :city
      t.string :pages
      t.integer :year
      t.string :url
      t.text :keywords
      t.text :abstract
      t.string :doi
      t.string :edition
      t.string :editor
      t.string :journal
      t.string :volume
      t.string :issue
      t.string :instituion
      t.date :date_of_last_access
      t.string :type_of_work
      t.string :university

      t.timestamps
    end
  end
  
  def self.down
    drop_table :publications
  end
end
