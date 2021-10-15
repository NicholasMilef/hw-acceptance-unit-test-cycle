class Movie < ActiveRecord::Base
    def self.with_director(director)
        where(director: director)
    end
    
    # From hw-bdd-cucumber (HW3)
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
end
