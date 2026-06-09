class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  before_action :set_movie, only: [:show, :edit, :update, :destroy]
end
