class Movie < ActiveRecord::Base
  def self.get_all_ratings
    self.find :all, :select => "rating", :group => "rating"
  end
end
