class Movie < ActiveRecord::Base

  def <=>(other)
    return 1 if other.release_date > self.release_date
    return 0 if other.release_date == self.release_date
    -1
  end

  def self.get_ratings
    ['G', 'PG', 'PG-13', 'R']
  end
end
