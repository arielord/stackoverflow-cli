class User
  attr_accessor :username, :reputation
  @@all = []

  def initialize(name, reputation)
    @name = name
    @reputation = reputation
    @@all << self
  end

  def self.all
    @@all
  end

end
