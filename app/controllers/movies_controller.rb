class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    col = params[:orderby]
    @sel_ratings = []
    @sel_ratings = params[:ratings].keys if params[:ratings]
    if (col == nil) & (@sel_ratings.empty?) & (session[:params] != nil) 
      redirect_to movies_path(), session[:params] 
    end
    @movies = nil
    if col
      @movies = (@movies ||= Movie).order(col)
    end
    if !@sel_ratings.empty?
      @movies = (@movies ||= Movie).where(:rating => @sel_ratings)
    end
    @movies = Movie.all if @movies == nil
    @all_ratings = Movie.get_all_ratings
    session[:params] = params
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
