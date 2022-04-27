class User::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to user_post_path(post),notice: "コメントを送信しました！"
  end

  def destroy
      PostComment.find(params[:id]).destroy
      redirect_to user_post_path(params[:post_id]),notice: "コメントを削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
