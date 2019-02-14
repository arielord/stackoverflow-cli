class User
  extend Concerns::Findable
  attr_accessor :username, :reputation, :posts, :answers
  @@all = []

  def initialize(username, reputation)
    @username = username
    @reputation = reputation
    @posts = []
    @answers = []
    @@all << self
  end

  def add_post(post)
    if !@posts.find {|p| p.title == post.title}
      @posts << post
    end
  end

  def self.create(username, reputation)
    User.new(username, reputation) unless User.find_by_username(username)
  end

  def self.all
    @@all
  end

end
