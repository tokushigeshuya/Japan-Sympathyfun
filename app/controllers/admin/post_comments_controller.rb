class Admin::PostCommentsController < ApplicationController
   before_action :authenticate_admin!

  def destroy
      PostComment.find(params[:id]).destroy
      redirect_to admin_post_path(params[:post_id]),notice: "コメントを削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
