#Scrape stackoverflow pages using tag queries

class Scraper

  def self.stackoverflow_results(search_tag)
    temp_file = open("https://stackoverflow.com/questions/tagged#{search_tag}")
    html = temp_file.read
    doc = Nokogiri::HTML(html)

    posts = doc.css
  end

  def self.stackoverflow_post(post_link)

  end

end
