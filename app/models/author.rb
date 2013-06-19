class Author < ActiveRecord::Base
  
  attr_accessible :first_name, :last_name, :title, :email, :search_name, :office, :street, :city, :zip_code,
                  :phone, :url, :cv, :image
  
  has_many :authorships
  has_many :publications, through: :authorships
  
  # paperclip
  
  validates_presence_of :first_name, :last_name
  
  has_attached_file :image, :styles => { :small => "350x250>" }
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  #methodes
  
  before_save do
    if self.search_name == nil
      self.search_name = self.title + " " + self.first_name + " " + self.last_name
    end
    if self.url == 'http://www.'
      self.url = ''
    end
  end
  
  def self.tokens(query)
    authors = where("search_name like ?", "%#{query}%")
    if !authors.empty?
      authors
    end
    # else no results found
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(search_name: $1).id }
    tokens.split(',')
  end
end
