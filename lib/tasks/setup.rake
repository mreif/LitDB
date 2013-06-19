namespace :own do
  
  desc "Downloads pdf files from the publication url column and at them to paperclip - just for migration issues"
  task :crawl_pdfs => :environment do
    
        Publication.where("url!=''").each do |pub|
          puts pub.id.to_s + "  -  " + pub.title
          puts pub.url
          source = pub.url.gsub(" ", "%20")
          puts source
          #if pub.id != 11596 and pub.id != 11645 and pub.id != 11688
              begin
              pub.upload = URI.parse(source)
              pub.save!
              puts pub.upload_content_type
            rescue
                puts pub.id.to_s + "404 Paper not available - URL deleded"
                #pub.url = ""
            end
          #end  
        end
        puts "Done, all available paper are added to paperclip"
  end
end