class Menu

  def display_post(post)
    puts "Title: #{post.title}"
    puts "Excerpt: #{post.excerpt}"
    puts "Posted by: #{post.user.username}"
  end

  def display_current_page(page)
    page.each {|post| display_post(post)}
  end

  def current_page(collection)
    
  end

end
