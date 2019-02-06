class Post
  attr_accessor :title, :link, :excerpt, :answered, :user, :reputation
  @@all = []

  def initialize(post_hash)
    post_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.create_from_collection(results_array)
    results_array.each {|post| Post.new(post)}
  end

  def self.all
    @@all
  end

end
