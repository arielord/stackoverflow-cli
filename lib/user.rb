class User
  extend Concerns::Findable
  attr_accessor :username, :reputation
  @@all = []

  def initialize(username, reputation)
    @username = username
    @reputation = reputation
    @@all << self
  end

  def self.create(username, reputation)
    User.new(username, reputation) unless User.find_by_username(username)
  end

  def self.all
    @@all
  end

end
