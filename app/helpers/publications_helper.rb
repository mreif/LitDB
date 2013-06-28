# encoding: utf-8

module PublicationsHelper
  
  # builds the authors string for a publication
  def getFormatedAuthors(authors)
    result = ""
    authors.each_with_index do |author, i|
      id = author.id
      result << '<a href="authors/'+ id.to_s + '">'
      result << author.first_name[0]
      result << ". "
      result << author.last_name
      result << '</a>'
      result << ((i < authors.length - 1)? ", " : "");
    end
    return result
  end
  
  
  # creates information string (publisher, pages etc...) for a publication
  def getInformationRow (pub)
    result = "";
    if !pub.published_in.empty?
      result << (pub.published_in.empty? ? "" : "In: " + pub.published_in)
      result << (pub.city.empty? ? "" : (", " + pub.city))
      result << (pub.pages.empty? ? "" : (", pp." + pub.pages))
      result << (pub.publisher.empty? ? "" : (", " + pub.publisher))
    else 
      result << (pub.journal.empty? ? "" : (pub.journal + ", "))
      result << (pub.volume.empty? ? "" : (pub.volume + ", "))
      result << (pub.issue.empty? ? "" : (pub.issue + ", "))
      result << (pub.city.empty? ? "" : (pub.city + ", "))
      result << (pub.pages.empty? ? "" : ("pp. " + pub.pages + ", "))
      result << (pub.publisher.empty? ? "" : pub.publisher)
    end
    return result
  end
  
  # generates the bibtex strings, publication types are mapped to bibtex types here
  def generate_bibtex pub
    
    result = ""
    
    authors = getBibTexAuthors pub
    id = authors.split(" ")[1] + pub.year.to_s + pub.title.split(" ")[0] + ",\n" 
    title = "title={" + (remove_umlaut(pub.title)) + "},\n"
    
    case pub.type_id
      when 1  # book -> book / inbook (authors || editors, title, publisher, year, pages ) (volume, city -> address, keywords -> key, editon)?
          result << ((pub.pages == "")? "@Book{" : "@InBook{")
          result << id
          result << title
          result << authors
          result << ((pub.editor == "")? "" : ("editor={" + pub.editor + "},\n"))
          result << "publisher={" + pub.publisher + "},\n"
          result << ((pub.book_title == "")? "" : "booktitle={" + pub.book_title + "},\n" )
          result << ((pub.pages == "")? "" : "pages={" + pub.pages + "},\n")
          result << ((pub.keywords == "")? "" : "key={" + pub.keywords + "},\n")
          result << "year={" + pub.year.to_s + "}\n}"
      when 3  # report -> techreport (author, title, institution, year)
          result << "@Techreport{" + id
          result << authors + ",\n"
          result << title
          result << authors
          result << "institution={" + pub.institution + "},\n"
          result << ((pub.keywords == "")? "" : "key={" + pub.keywords + "},\n")
          result << "year={" + pub.year.to_s + "}\n}"
      when 4 # thesis -> can't distinguish between phd -/ mastersthesis (author, title, university --> school, year) (keywords -> key)?
          result << "@thesis{" + id
          result << title
          result << authors
          result << "university={" + pub.university + "},\n"
          result << ((pub.keywords == "")? "" : "key={" + pub.keywords + "},\n")
          result << "year={" + pub.year.to_s + "}\n}"
      when 7 # articel -> article article (author, title, journal, year) (volume, pages, keywords --> key)?
          result << "@Article{" + id
          result << title
          result << authors
          result << "journal={" + pub.journal + "},\n"
          result << ((pub.pages == "")? "" : "pages={" + pub.pages + "},\n")
          result << ((pub.volume == "")? "" : "volume={" + pub.volume + "},\n")
          result << ((pub.keywords == "")? "" : "key={" + pub.keywords + "},\n")
          result << "year={" + pub.year.to_s + "}\n}"
      when 8 # inproceedings -> proceedings (title, year) / inproceedings (author, title, booktile, year), can be distinguished by booktitle 
             #                (Editor, Volume, city --> address, publisher, institution --> organization, keywords --> key)?
          result << ((pub.book_title == "")? "@Proceedings{" : "@InProceedings{")
          result << id
          result << title
          result << authors
          result << ((pub.publisher == "")? "" : "publisher={" + pub.publisher + "},\n")
          result << ((pub.editor == "")? "" : "editor={" + pub.editor + "},\n")
          result << ((pub.volume == "")? "" : "volume={" + pub.volume + "},\n")
          result << ((pub.city == "")? "" : "address={" + pub.city + "},\n")
          result << ((pub.institution == "")? "" : "organization={" + pub.institution + "},\n")
          result << ((pub.book_title == "")? "" : "booktitle={" + pub.book_title + "},\n")
          result << ((pub.pages == "")? "" : "pages={" + pub.pages + "},\n")
          result << ((pub.keywords == "")? "" : "key={" + pub.keywords + "},\n")
          result << "year={" + pub.year.to_s + "}\n}"
      else   # generic, webpage, Misc
          result << "@Misc{" + id
          result << title
          result << authors
          result << ((pub.publisher == "")? "" : "publisher={" + pub.publisher + "},\n")
          result << ((pub.editor == "")? "" : "editor={" + pub.editor + "},\n")
          result << ((pub.volume == "")? "" : "volume={" + pub.volume + "},\n")
          result << ((pub.city == "")? "" : "address={" + pub.city + "},\n")
          result << ((pub.institution == "")? "" : "organization={" + pub.institution + "},\n")
          result << ((pub.book_title == "")? "" : "booktitle={" + pub.book_title + "},\n")
          result << ((pub.pages == "")? "" : "pages={" + pub.pages + "},\n")
          result << ((pub.keywords == "")? "" : "key={" + pub.keywords + "},\n")
          result << ((pub.year == "")? "" : "year={" + pub.year.to_s + "}\n")
          result << "}"
    end
    return result
  end
  
  # gernerates the author line for the bibtex entry
  private
  def getBibTexAuthors pub
    result = "author={"
    authors = pub.authors
    authors.each_with_index do |author, index|
      result << (remove_umlaut(author.first_name)) + " " + (remove_umlaut(author.last_name))
      if index < authors.size - 1
        result << " and "
      end
    end
    return result << "},\n"
  end
  
  # replaces the german umlauts to correct bibtex format
  private
  def remove_umlaut input
   input.gsub(/[äöü]/, 'ä' => '{\"a}', 'ö' => '{\"o}', 'ü' => '{\"u}')
  end
  
end
