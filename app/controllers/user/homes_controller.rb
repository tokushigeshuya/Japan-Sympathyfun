class User::HomesController < ApplicationController
  def top
    @post_all = Post.all
  end

  def about
  end
end
