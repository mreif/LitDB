class Type < ActiveRecord::Base
  
  has_many :publications
  
  attr_accessible :format
end
