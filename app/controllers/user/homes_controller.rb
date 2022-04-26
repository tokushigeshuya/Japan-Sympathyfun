class User::HomesController < ApplicationController
  def top
    @post_all = Post.page(params[:page]).order("created_at DESC")
  end

  def about
  end
  
  def search
  end
end
