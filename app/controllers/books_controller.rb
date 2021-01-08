class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
  	book = Book.new(book_params)
  	book.user_id = current_user.id
  	if book.save
      flash[:notice]= "Created successfully"
      redirect_to book_path(book.id)
    else
      @book = book
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
  	@books = Book.all
  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
     @book = Book.find(params[:id])

     if current_user != @book.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]= "Updated successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
