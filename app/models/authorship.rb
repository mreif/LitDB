class Authorship < ActiveRecord::Base
  
  #relationships
  belongs_to :publication
  belongs_to :author
end