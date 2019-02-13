class Answer
  extend Concerns::Findable
  attr_accessor :question, :answers, :username, :reputation, :post, :user
  @@all = []

  #Add user method that ensure user also adds posts

  def initialize(answers_hash)
    answers_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

end
