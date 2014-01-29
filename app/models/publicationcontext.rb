class Publicationcontext < ActiveRecord::Base
  attr_accessible :project_id, :publication_id
  
  #relationships
  belongs_to :project
  belongs_to :publication
end
