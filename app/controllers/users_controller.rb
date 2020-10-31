class UsersController < ApplicationController
before_action:authenticate_user!
  def show
  	@book_new = Book.new
  	@user = User.find(params[:id])
  	@books = @user.books.page(params[:page])
  end

  def index
      @users = User.all
      @user = current_user
      @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
      if current_user.id != @user.id
        redirect_to user_path(current_user.id)
      end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
  	  redirect_to user_path(current_user.id)
      flash[:success_user_edit] = "You have successfully updated your information."
    else
      render :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
