class Answer
  extend Concerns::Findable
  attr_accessor :answer, :username, :reputation, :post, :user, :question
  @@all = []

  #Add user method that ensure user also adds posts

  def initialize(answers_hash)
    answers_hash.each {|key, value| self.send("#{key}=", value)}
    user = User.create(self.username, self.reputation)
    self.user = user
    add_answer_to_post
    @@all << self
  end

  def user=(user)
    if user
      @user = user
      @user.add_answer(self)
    else
      @user = User.find_by_username(self.username)
      @user.add_answer(self)
    end
  end

  def add_answer_to_post
    post = Post.all.find {|post| post.question == self.question}
    post.answers << self unless post.answers.find {|ans| ans.answer == self.answer}
  end

  def self.create_from_collection(answer_array)
    answer_array.each {|post| Answer.new(post)} unless answer_array.size == 0
  end

  def self.all
    @@all
  end

end
