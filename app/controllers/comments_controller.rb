# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to polymorphic_url(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render "#{@commentable.model_name.plural}/show", status: :unprocessable_entity
    end
  end

  private

  def set_commentable
    if params[:book_id]
      @book = Book.find(params[:book_id])
    elsif params[:report_id]
      @report = Report.find(params[:report_id])
    end
    @commentable = @book || @report
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
