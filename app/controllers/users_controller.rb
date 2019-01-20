class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update]
  before_action :verify_current_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
  end

  def edit; end

  def update
    if current_user.update(params.require(:user).permit(:photo))
      redirect_to current_user
    end
  end

  private

  def verify_current_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to edit_user_path(current_user)
    end
  end
end
