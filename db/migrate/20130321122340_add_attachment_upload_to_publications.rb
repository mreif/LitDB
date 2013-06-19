class AddAttachmentUploadToPublications < ActiveRecord::Migration
  def self.up
    change_table :publications do |t|
      t.attachment :upload
    end
  end

  def self.down
    drop_attached_file :publications, :upload
  end
end
