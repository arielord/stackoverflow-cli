class Menu
  attr_accessor :page, :collection, :selected_post, :prompt

  def initialize()
    @prompt = TTY::Prompt.new
    @page = 1
    start_menu
  end

  def display_post(post)
    puts "Title: #{post.title}"
    puts "Excerpt: #{post.excerpt}"
    puts "Posted by: #{post.user.username}"
  end

  def display_entire_post(post)
    answer_hash = Scraper.stackoverflow_answers_and_info(post.link)
    Answer.create_from_collection(answer_hash)
    puts "Title: #{post.title}"
    puts "Question: #{post.question}"
    puts "Posted by: #{post.user.username}"

    if post.answers.size > 0
      puts ""
      puts "Answers:"
      post.answers.each do |answer|
        puts "#{answer.answer}"
        puts "Posted by: #{answer.user.username}"
      end
    else
      puts ""
      puts "Post is currently unanswered"
    end
  end

  def next_page
    @page += 1
  end

  def previous_page
    @page -= 1 unless @page == 1
  end

  def current_page
    @collection[(@page-1)*3...@page*3]
  end

  def format_input_for_search(tag)
    tag.downcase.split().join("-")
  end

  def select_array
    arr = []
    if current_page
      current_page.each {|post| arr << post.title}
    end
    arr
  end

  def first_page
    arr = select_array
    arr << "next"
    arr << "exit"
    @prompt.select("Choose post to learn more", arr)
  end

  def middle_pages
    arr = select_array
    arr << "next"
    arr << "prev"
    arr << "exit"
    @prompt.select("Choose post to learn more:", arr)
  end

  def last_page
    @prompt.select("Ooops no more posts available.", ["prev"])
  end

  def event_listener(input)
    case input
    when "next"
      next_page
    when "prev"
      previous_page
    when "exit"
      "exit"
    else
      post = current_page.find{|post| post.title == input}
      display_post(post)
      if @prompt.yes?("Would you like to see the full post?")
        system("clear")
        display_entire_post(post)
        @prompt.ask("Press enter to exit.")
      end
    end
  end

  def start_menu
    response = ""
    until response == "exit"
      @page = 1
      response = @prompt.ask("Please enter a tag to search for on stackoverflow.com \nor hit enter to", default: "exit")
      if response != "exit"
        flag = true
        if !Post.all.any? {|post| post.tag == response}
          begin
            posts = Scraper.stackoverflow_posts(format_input_for_search(response))
            Post.create_from_collection(posts)
          rescue OpenURI::HTTPError => ex
            system("clear")
            flag = false
            puts "Tag not found. Please try again."
          end
        end
          @collection = Post.all.find_all do |item|
            item.tag == response
          end

        if flag
          system("clear")
          input = event_listener(first_page)
          until input == "exit"
            system("clear")
            if select_array == []
              input = event_listener(last_page)
            elsif @page == 1
              input = event_listener(first_page)
            else
              input = event_listener(middle_pages)
            end
          end
        end
      end
    end

    puts "Thanks for using my stackoverflow CLI!"
  end

end
