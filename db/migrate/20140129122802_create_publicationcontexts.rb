class CreatePublicationcontexts < ActiveRecord::Migration
  def change
    create_table :publicationcontexts do |t|
      t.integer :publication_id
      t.integer :project_id

      t.timestamps
    end
  end
end
