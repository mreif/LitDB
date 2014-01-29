require 'pdf/info'
require 'htmlentities'

class Publication < ActiveRecord::Base
  
  # accessible attributes
  attr_accessible :abstract, :city, :date_of_last_access, :doi, :edition, :institution, :issue, :journal, :university,
   :keywords, :pages, :publisher, :title, :url, :volume, :year, :upload, :author_tokens, :project_tokens, :type_id,
    :editor, :book_title, :authorships, :published_in, :publicationcontexts
  
  attr_reader :author_tokens, :project_tokens
 
  # relationships
  has_many :authorships
  has_many :authors, through: :authorships
  
  has_many :publicationcontexts
  has_many :projects, through: :publicationcontexts
  
  belongs_to :type
  

  # validations
  
  validates :title, :presence => true, :uniqueness => true, :if => :rdy_to_save?
  validates_presence_of :authors, :if => :rdy_to_save?
  #validates_attachment :upload, :presence => true
  #validates_attachment_content_type :upload, :content_type => ['application/pdf', 'application/octet-stream', 'application/postscript', 'application/x-gzip']
  
  # paperclip
  
  has_attached_file :upload,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"
  
  #methods
  
  before_save do
    if self.url == 'http://www.'
      self.url = ''
    end
    self.authorships.each_with_index do |authorship, i|
      authorship.pos = i
    end
  end
  
  # extract the metadata of a given pdf via the pdf_info gem.
  def extract_metadata
    path = upload.queued_for_write[:original].path
    info = PDF::Info.new(path).metadata
    self.title = (self.title != nil && self.title.empty?)? info[:title] : self.title
    self.keywords = (self.keywords != nil && self.keywords.empty?)? info[:keywords] : self.keywords
    tmp_authors = HTMLEntities.new.decode(info[:author]).split(",")
    res = Hash.new
    res.store("authors", "")
    tmp_authors.each do |author|
      tmp = Author.where("lower(search_name) LIKE :input", input: "%#{author.strip.downcase}")
      if tmp != [] || tmp.size == 1
        self.authors << tmp
        pp tmp
      else
        res.store("authors", res["authors"] + author + ",") 
      end
    end
    pp info
    res.store("title",(self.title != nil && !self.title.empty?)? true : false)
    pp res
  end
  
  def author_tokens=(tokens)
    self.author_ids = Author.ids_from_tokens(tokens)
  end
  
  def project_tokens=(tokens)
    self.project_ids = Project.ids_from_tokens(tokens)
  end
  
  #used for contitional post, only need to validate the attributes on save (pdf_upload)
  
  def set_rdy_to_save bool
    @rdy_to_save = bool
  end
  
  def rdy_to_save?
      @rdy_to_save
  end
  
  # query for the publications search on the 'project' site
  def self.tokens(query)
    publications = where("title like ?", "%#{query}%")
    if !publications.empty?
      publications
    end
    # else no results found
  end
  
  # extract ids from the found authors
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(title: $1).id }
    tokens.split(',')
  end
end
