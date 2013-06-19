class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :format

      t.timestamps
    end
  end
end
