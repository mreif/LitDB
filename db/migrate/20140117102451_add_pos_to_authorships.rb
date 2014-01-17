class AddPosToAuthorships < ActiveRecord::Migration
  def change
    add_column :authorships, :pos, :integer
  end
end
