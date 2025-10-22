# frozen_string_literal: true

class Books::CommentsController < CommentsController
  private

  def set_commentable
    @commentable = @book = Book.find(params[:book_id])
  end

  def commentable_show
    'books/show'
  end
end
