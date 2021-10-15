# spec/controllers/movie_spec.rb

require 'rails_helper.rb'

# model rspec
RSpec.describe Movie, :type => :model do
    it "should return the correct matches for movies by the same director" do
        @movie1 = Movie.new(title: "Test Movie 1", director: "Director 1")
        @movie1.save
        @movie2 = Movie.new(title: "Test Movie 2", director: "Director 1")
        @movie2.save
        expect(Movie.with_director(@movie1.director).count).to eq(2)
    end
    
    it "should not return matches of movies by different directors" do
        @movie1 = Movie.new(title: "Test Movie 1", director: "Director 1")
        @movie1.save
        @movie2 = Movie.new(title: "Test Movie 2", director: "Director 2")
        @movie2.save
        expect(Movie.with_director(@movie1.director).count).to eq(1)
    end
end