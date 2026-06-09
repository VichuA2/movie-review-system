class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie
                .left_joins(:reviews)
                .select("movies.*, AVG(reviews.rating) AS avg_rating")
                .group("movies.id")
                .search_by_name(params[:search])
                .filter_by_release_date(params[:release_date])
                .order(Arel.sql("AVG(reviews.rating) DESC"))
  end

  def show
    @reviews = @movie.reviews.includes(:user)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "Movie created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "Movie updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Movie deleted successfully."
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :release_date)
  end
end
