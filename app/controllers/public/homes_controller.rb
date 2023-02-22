class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.status_public.all.limit(8).order(created_at: :desc)
  end
  
end
