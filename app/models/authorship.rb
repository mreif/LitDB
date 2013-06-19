class Authorship < ActiveRecord::Base
  belongs_to :publication
  belongs_to :author
end