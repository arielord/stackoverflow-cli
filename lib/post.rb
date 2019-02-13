class Post
  extend Concerns::Findable
  attr_accessor :title, :question, :link, :excerpt, :answered, :username, :reputation, :answers, :user
  @@all = []

  def initialize(post_hash)
    post_hash.each {|key, value| self.send("#{key}=", value)}
    self.user = User.create(self.username, self.reputation)
    @answers = []
    @@all << self
  end

  def self.create_from_collection(results_array)
    results_array.each {|post| Post.new(post)}
  end

  def self.all
    @@all
  end

end
