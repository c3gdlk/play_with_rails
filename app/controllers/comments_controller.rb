class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def create
    @post.comments.create comment_params

    redirect_to @post
  end

  def destroy
    comment = @post.comments.find params[:id]
    comment.destroy

    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find params[:post_id]
  end
end
