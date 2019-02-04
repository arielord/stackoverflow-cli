#Scrape stackoverflow pages using tag queries

class Scraper

  def self.stackoverflow_results(search_tag)
    results_array = []
    temp_file = open("https://stackoverflow.com/questions/tagged#{search_tag}")
    html = temp_file.read
    doc = Nokogiri::HTML(html)

    doc.css(".question-summary").each do |post|
      title = post.css("h3").text
      excerpt = post.css(".excerpt").text.gsub(/\r/, " ").gsub(/\n/, " ").strip
      link = post.css("h3 a @href").text
      answered_status = post.css(".stats .status @class").text
      # votes = post.css(".votes")
      # views = post.css(".views")

      question = {title: title, excerpt: excerpt, link: link, answered: answered_status}
      results_array << post
    end

    results_array
  end

  def self.stackoverflow_post(post_link)
    temp_file = open("https://stackoverflow.com#{post_link}")
    html = temp_file.read
    doc = Nokogiri::HTML(html)

    doc.css
  end

end