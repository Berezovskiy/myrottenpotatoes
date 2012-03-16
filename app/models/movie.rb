class Movie < ActiveRecord::Base
  def get_all_ratings
    self.find(:all, :select => 'DISTINCT rating')
  end
end
