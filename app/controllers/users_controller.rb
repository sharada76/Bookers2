class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]= "Updated successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])

    if current_user != @user
      redirect_to user_path(current_user.id)
    end

    @book = Book.new
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
