class Menu
  attr_accessor :page

  def initialize()
    @page = 1
  end

  def display_post(post)
    puts "Title: #{post.title}"
    puts "Excerpt: #{post.excerpt}"
    puts "Posted by: #{post.user.username}"
  end

  def display_current_page(page)
    page.each {|post| display_post(post)}
  end

  def next_page
    @page += 1
  end

  def previous_page
    @page -= 1 unless @page == 1
  end

  def current_page(collection)
    collection[(@page-1)*3...@page*3]
  end

  def search_for_tag(tag)
    tag.downcase.split().join("-")
  end

  def choice_menu

  end

  def start_menu
    prompt = TTY::Prompt.new
    response = ""
    until response == "exit"
      response = prompt.ask("Please enter a tag to search for on stackoverflow.com", default: "or type \"exit\" to exit")
      if response != "exit"
        puts "it's working"
      end
    end
    puts "Thanks for using my stackoverflow CLI!"
  end

end
