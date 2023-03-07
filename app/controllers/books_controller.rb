class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @book=Book.new
  end

  def show
    @Book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path,notice: "successfully delete book!"
  end

  private

  def book_params
    params.require(:book).permit(:image,:title,:body)
  end
  
  def  is_matching_login_user
    @book = Book.find(params[:id])
   unless @book.user == current_user
     redirect_to books_path
   end
  end
end
