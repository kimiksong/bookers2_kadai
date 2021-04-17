class BooksController < ApplicationController

  before_action :correct_user, only:[:edit]

  def new
    @book=Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success]='successfully'
      redirect_to book_path(@book)
    else
      @user= current_user
      @books=Book.all
      render template: "users/show"
    end
  end

  def index
    @user = current_user
    @books=Book.all
    @book = Book.new
  end

  def show
     @book = Book.find(params[:id])
     @book1=Book.new
     @user = @book.user
     @book_comment=BookComment.new

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success]='successfully'
      redirect_to book_path(@book)
    else
      render 'books/edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:body, :title)
  end

  def correct_user
    @book=Book.find(params[:id])
    @user=@book.user
    if current_user != @user
      redirect_to books_path
    end
  end
end
