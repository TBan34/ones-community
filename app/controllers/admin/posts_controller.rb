class Admin::PostsController < ApplicationController
  
  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.page(params[:page]) : Post.status_public.order(created_at: :desc).page(params[:page])
    if params[:user_id]
      @posts = Post.status_public.where(user_id: params[:user_id]).order(created_at: :desc).page(params[:page])
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post.id), success: "投稿を更新しました"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path, danger: "投稿を削除しました"
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body, :time, :place, :belonging, :image, tag_ids: [])
  end
  
end
