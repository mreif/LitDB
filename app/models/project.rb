class Project < ActiveRecord::Base
  attr_accessible :active, :description, :email, :name, :organisation, :url, :publication_tokens, :publicationscontexts
  
  attr_reader :publication_tokens
  
  has_many :publicationcontexts
  has_many :publications, through: :publicationcontexts
  
  def to_param
    name
  end
  
  # query for the authors search on the 'new publicaiton' site
  def self.tokens(query)
    projects = where("name like ?", "%#{query}%")
    if !projects.empty?
      projects
    end
    # else no results found
  end
  
  # extract ids from the found authors
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
  
  def publication_tokens=(tokens)
    self.publication_ids = Publication.ids_from_tokens(tokens)
  end
  
end
