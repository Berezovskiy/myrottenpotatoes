class Movie < ActiveRecord::Base
  def self.get_all_ratings
    self.select(:rating).uniq
  end
end
