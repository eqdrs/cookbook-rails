class CuisinesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :verify_admin, only: %i[new create edit update]

  def index
    @cuisines = Cuisine.all
  end

  def show
    @cuisine = Cuisine.find(params[:id])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      render :new
    end
  end

  def edit
    @cuisine = Cuisine.find(params[:id])
  end

  def update
    @cuisine = Cuisine.find(params[:id])
    if @cuisine.update(cuisine_params)
      redirect_to @cuisine
    else
      render :edit
    end
  end

  private

  def verify_admin
    (!current_user.admin) && (redirect_to root_path)
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end
end
