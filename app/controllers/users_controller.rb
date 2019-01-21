class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show my_lists]

  def show
    @user = User.find(params[:id])
  end

  def my_lists
    @lists = current_user.recipes_lists
  end
end
