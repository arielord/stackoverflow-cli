module Concerns::Findable
  def clear
    self.all.clear
  end

  def find_by_username(username)
    self.all.find {|item| item.username == username}
  end

  def find_by_reputation_score(score)
    self.all.find {|item| item.reputation. >= score}
  end

end
