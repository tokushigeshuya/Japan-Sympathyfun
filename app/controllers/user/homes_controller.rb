class User::HomesController < ApplicationController
  def top
    @post_all = Post.all.order("created_at DESC")
  end

  def about
  end
end
