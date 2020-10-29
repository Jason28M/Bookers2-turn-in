class BooksController < ApplicationController
before_action :authenticate_user!
  def index
  	@book = Book.new
  	@books = Book.all
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	@book.save
    if @book.save
      redirect_to "/books/#{@book.id}"
      flash[:success] = "You have created book successfully."
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :books
    end
  end


  def edit
      @book = Book.find(params[:id])
      if @book.user.id != current_user.id
        redirect_to books_path
      end
  end

  def update
  	@book = Book.find(params[:id])
  	@book.update(book_params)
    if @book.update(book_params)
      redirect_to book_path(params[:id])
      flash[:success_edit] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
    redirect_to "/books"
  end

  def show
    	@book = Book.find(params[:id])
      @user = User.find(current_user.id)
      @book_new = Book.new
  end

  def books
      @book = Book.new
      @books = Book.all
      @user = User.find(current_user.id)
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

    def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end