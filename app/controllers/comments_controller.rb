# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new; end

  def edit; end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    return unless @comment.save

    redirect_to @commentable, notice: 'Comment was successfully created'
  end

  def update
    return unless @comment.update(comment_params)

    redirect_to @commentable, notice: 'Comment was successfully updated.'
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
