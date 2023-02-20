class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all.limit(8).order(created_at: :desc)
  end
  
end
