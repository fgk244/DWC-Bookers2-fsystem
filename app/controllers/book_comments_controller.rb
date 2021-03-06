class BookCommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(destroy)

  def create
    book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.new(book_comment_params)
    book_comment.book_id = book.id
    book_comment.save
    redirect_to book_path(book.id)


  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    @book_comments = Book.find(book_comment.book_id).book_comments
    redirect_to book_path(book_comment.book_id)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:book_comments).merge(book_id: params[:book_id])
  end

  def ensure_correct_user
    book_comment = BookComment.find(params[:id])
    return if book_comment.user_id == current_user.id
    flash[:danger] = '権限がありません'
    redirect_back fallback_location: root_path
  end

end
