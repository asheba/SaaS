class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    update_session(params)
    @ordered_by = params[:order_by]
    @ratings = []
    @ratings = params[:ratings].keys unless params[:ratings].blank?
    full_params = params.merge(session){ |key, oldval, newval| oldval }
    redirect_to movies_path(full_params) if full_params != params

    @all_ratings = Movie.get_ratings

    @movies = Movie.find_all_by_rating(@ratings)
    @movies.sort!{ |a,b| a.send(@ordered_by) <=> b.send(@ordered_by) } unless @movies.blank? or @ordered_by.blank?
    
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

  def update_session(params)
    relevant_params = params.select{ |k,v| ["order_by", "ratings"].include?(k) }
    session.update(relevant_params)
  end

end
