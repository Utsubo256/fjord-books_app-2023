# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: :destroy
  before_action :authorized_user, only: :destroy

  def create
    @comment = @commentable.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to polymorphic_url(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @comments = @commentable.comments.preload(:user).order(created_at: :asc)
      flash.now[:alert] = t('controllers.common.notice_create_failure', name: Comment.model_name.human)
      render commentable_show, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    redirect_to polymorphic_url(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def authorized_user
    return if @comment.user == current_user

    redirect_to polymorphic_url(@commentable), alert: t('errors.messages.not_permitted')
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
