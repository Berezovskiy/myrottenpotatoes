class Movie < ActiveRecord::Base
  def self.get_all_ratings
    self.find(:all).group(:rating)
  end
end
