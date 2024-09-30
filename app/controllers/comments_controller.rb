# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    @comment.save

    redirect_to @commentable, notice: 'Comment was successfully created.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
