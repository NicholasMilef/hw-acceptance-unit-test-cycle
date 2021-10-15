# spec/controllers/movies_controller_spec.rb

require 'rails_helper.rb'

RSpec.describe MoviesController, :type => :controller do
    describe "When the specific movie has a director" do
        it "should show a list of movies with the same director" do
            @movie = Movie.new(title: "Test Movie", director: "Director 1")
            @movie.save
            get :find_with_same_director, id: @movie.id
            expect(response).to render_template(:index)
        end
    end
    
    describe "When the specific movie does not have a director" do
        it "should redirect to the homepage" do
            @movie = Movie.new(title: "Test Movie")
            @movie.save
            get :find_with_same_director, id: @movie.id
            expect(response).to redirect_to("http://test.host/movies?no_director=1&title=Test+Movie")
        end
    end
    
    describe "When the specific movie gets deleted" do
        it "should redirect to the homepage" do
            @movie = Movie.new(title: "Test Movie")
            @movie.save
            delete :destroy, id: @movie.id
            expect(response).to redirect_to("http://test.host/movies")
        end
    end
    
    describe "When the specific movie gets shown" do
        it "should show the movie page" do
            @movie = Movie.new(title: "Test Movie")
            @movie.save
            get :show, id: @movie.id
            expect(response).to render_template(:show)
        end
    end

    describe "When the homepage is shown" do
        it "should show the homepage" do
            get :index
            expect(response).to render_template(:index)
        end
    end
end