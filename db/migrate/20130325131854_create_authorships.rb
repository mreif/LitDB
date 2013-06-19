class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.belongs_to :publication
      t.belongs_to :author

      t.timestamps
    end
    add_index :authorships, :publication_id
    add_index :authorships, :author_id
  end
end