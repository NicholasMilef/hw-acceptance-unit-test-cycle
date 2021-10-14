class Movie < ActiveRecord::Base
    def self.with_director(director)
        where(director: director)
    end
end
