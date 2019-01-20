class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update]
  before_action :verify_current_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    redirect_to current_user if current_user.update(params.require(:user)
                                                    .permit(:photo))
  end

  def my_lists
    @lists = current_user.recipes_lists
  end

  private

  def verify_current_user
    @user = User.find(params[:id])
    (@user != current_user) && (redirect_to edit_user_path(current_user))
  end
end
