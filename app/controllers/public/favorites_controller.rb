class Public::FavoritesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
  end
  
  def index
    @user = current_user
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
  end
  
end
