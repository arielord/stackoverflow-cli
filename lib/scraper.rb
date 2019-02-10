#Scrape stackoverflow pages using tag queries
require "open-uri"

class Scraper

  def self.create_nokogiri_object(url, search) #helper function
    temp_file = open("#{url}#{search}")
    html = temp_file.read
    Nokogiri::HTML(html)
  end

  def self.stackoverflow_results(search_tag)
    results_array = []
    doc = create_nokogiri_object("https://stackoverflow.com/questions/tagged/", search_tag)

    doc.css(".question-summary").each do |post|
      title = post.css("h3").text
      excerpt = post.css(".excerpt").text.gsub(/\r/, " ").gsub(/\n/, " ").strip
      link = post.css("h3 a @href").text
      answered_status = post.css(".stats .status strong").text
      user_name = post.css(".user-info div a").text
      reputation_score = post.css(".user-info .reputation-score").text

      question = {title: title, excerpt: excerpt, link: link, answered: answered_status, user: user_name, reputation: reputation_score}
      results_array << question
    end

    results_array
  end

  def self.stackoverflow_post(post_link)
    doc = create_nokogiri_object("https://stackoverflow.com", post_link)

    question = doc.css(".question .post-text").text.gsub(/\r/,"").gsub(/\n/, "").strip
    answers = doc.css("#answers .post-text").collect do |answer|
      answer.text.gsub(/\r/,"").gsub(/\n/, "").strip
    end

    post_info = [question, answers]
  end

end
