class Answers
  attr_accessor :user, :reputation, :post

  def initialize(answers_hash)
    answers_hash.each {|key, value| self.send("#{key}=", value)}
    @@all << self
  end

end
