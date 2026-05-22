class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authorize_review_owner, only: [:edit, :update, :destroy]

  def index
    @reviews = @movie.reviews.includes(:user)
  end

  def show; end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Review created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to movie_reviews_path(@movie), notice: "Review updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to movie_reviews_path(@movie), notice: "Review deleted successfully."
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def authorize_review_owner
    if @review.user_id != current_user.id
      redirect_to movie_reviews_path(@movie), alert: "You can edit only your own review."
    end
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end