class User::PostCommentsController < ApplicationController
  before_action :authenticate_user_or_admin!, except: [:create,:destroy]

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to user_post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to user_post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
