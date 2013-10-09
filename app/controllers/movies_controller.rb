class MoviesController < ApplicationController

  def show
  	if(params[:ratings] == nil)
  		@selected_ratings = @all_ratings
  	else
  		@selected_ratings = params[:ratings]
  	end
  	
  	if(params[:OrderBy] == nil)
  		@OrderBy = ''
  	else
  		@OrderBy = params[:OrderBy]
  	end
  	
  	
  	# save off the session
  	session[:ratings] = @selected_ratings
  	session[:OrderBy] = @OrderBy
  	
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
  	@all_ratings = Movie.getUniqueMovieRatings
  	
  	if(!params[:ratings] and session[:ratings])
  		temp = {:ratings => session[:ratings], :OrderBy => session[:OrderBy]}
  		redirect_to movies_path(temp)
  	end
  	
  	if(params[:ratings] == nil)
  		@selected_ratings = @all_ratings
  	else
  		@selected_ratings = params[:ratings].keys
  	end
  	
  	if(params[:OrderBy] == nil)
  		@OrderBy = ''
  	else
  		@OrderBy = params[:OrderBy]
  	end
  	
    @movies = Movie.where(rating: @selected_ratings).order(@OrderBy)
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
