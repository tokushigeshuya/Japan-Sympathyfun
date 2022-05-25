class User::HomesController < ApplicationController
  def top
    @post_all = Post.page(params[:page]).per(4).order("created_at DESC")
    @rank = Post.find(Favorite.group(:post_id).order('count(post_id) DESC').limit(3).pluck(:post_id))
  end

  def about
  end
  
  def search
  end
end
