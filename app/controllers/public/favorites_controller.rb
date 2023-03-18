class Public::FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    post.create_notification_favorite!(current_user)
  end

  def index
    favorited_post_ids = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.where(id: favorited_post_ids).order(created_at: :desc).page(params[:page])
  end

  def destroy
    @post = Post.find(params[:post_id])
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
  end
end
