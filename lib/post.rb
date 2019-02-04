class Post
  attr_accessor :title, :link, :excerpt, :answered_status
  @@all = []

  def initialize(results_array)
    results_array.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.create_from_collection(results_array)
    results_array.each {|post| Post.new(post)}
  end

  def self.all
    @@all
  end

end
