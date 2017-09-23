class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render action: :show, status: :created
    else
      render_invalid_params_error(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :age)
  end
end
