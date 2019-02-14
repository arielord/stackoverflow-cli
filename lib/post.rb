class Post
  extend Concerns::Findable
  attr_accessor :title, :question, :link, :excerpt, :answered, :username, :reputation, :answers, :user
  @@all = []

  def initialize(post_hash, answers = nil)
    post_hash.each {|key, value| self.send("#{key}=", value)}
    @answers = answers
    user = User.create(self.username, self.reputation)
    self.user = user
    @@all << self
  end

  def user=(user)
    if user
      @user = user
      @user.add_post(self)
    else
      @user = User.find_by_username(self.username)
      @user.add_post(self)
    end
  end

  # def find_by_title(title)
  #   @@all.find {|title_name| title_name = title}
  # end

  def self.create_from_collection(results_array)
    results_array.each {|post| Post.new(post)}
  end

  def self.all
    @@all.uniq{|post| post.title}
  end

end
