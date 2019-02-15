#Scrape stackoverflow pages using tag queries
require "open-uri"

class Scraper

  def self.create_nokogiri_object(url, search) #helper function
    temp_file = open("#{url}#{search}")
    html = temp_file.read
    Nokogiri::HTML(html)
  end

  def self.get_question(link)
    doc = create_nokogiri_object("https://stackoverflow.com", link)
    question = doc.css(".question .post-text").text.gsub(/\r/,"").gsub(/\n/, "").strip
  end

  def self.stackoverflow_posts(search_tag)
    results_array = []
    doc = create_nokogiri_object("https://stackoverflow.com/questions/tagged/", search_tag)

    doc.css(".question-summary").each do |post|
      title = post.css("h3").text
      excerpt = post.css(".excerpt").text.gsub(/\r/, " ").gsub(/\n/, " ").strip
      link = post.css("h3 a @href").text
      answered_status = post.css(".stats .status strong").text
      username = post.css(".user-info div a").text
      reputation_score = post.css(".user-info .reputation-score").text.gsub(/,/,"").to_i
      question = get_question(link)

      question_hash = {title: title, excerpt: excerpt, question: question, link: link, answered: answered_status, username: username, reputation: reputation_score}
      results_array << question_hash
    end

    results_array
  end

  def self.stackoverflow_answers_and_info(post_link)
    doc = create_nokogiri_object("https://stackoverflow.com", post_link)
    answer_array = []

    username = doc.css(".user-info div a").collect {|un| un.text}.reject {|i| i == ""}
    reputation_score = doc.css(".user-info .reputation-score").collect {|rs| rs.text.gsub(/,/,"").to_i}
    question = doc.css(".question .post-text").text.gsub(/\r/,"").gsub(/\n/, "").strip
    answers = doc.css("#answers .post-text").collect {|answer| answer.text.gsub(/\r/,"").gsub(/\n/, "").strip}

    answers.each do |answer|
      index = answers.index(answer)
      answer_hash = {question: question, answer: answer, username: username[index+1], reputation: reputation_score[index+1]}
      answer_array << answer_hash
    end

    answer_array
  end

end
