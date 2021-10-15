# spec/controllers/movies_controller_spec.rb

require 'rails_helper.rb'

RSpec.describe MoviesController, :type => :controller do
    describe "When the specific movie has a director" do
        it "should show a list of movies with the same director" do
            @movie = Movie.new(title: "Test Movie", director: "Director 1")
            @movie.save
            get :find_with_same_director, id: @movie.id
            expect(response.body).to render_template(:index)
        end
    end
    
    describe "When the specific movie does not have a director" do
        it "should redirect to the homepage" do
            @movie = Movie.new(title: "Test Movie")
            @movie.save
            get :find_with_same_director, id: @movie.id
            expect(response.body).to render_template(:index)
        end
    end
end