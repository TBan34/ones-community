class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag = Tag.find(params[:post][:tag_ids])
    @post.tags << tag
    @post.save
    redirect_to posts_path
  end
  
  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.status_public.order(created_at: :desc).page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    
    if @post.status_private? && @user != current_user
      redirect_to posts_path
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.user.id = current_user.id
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.user.id = current_user.id
    if @post.destroy
      redirect_to posts_path
    end
  end
  
  def draft
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.status_private.order(created_at: :desc).page(params[:page])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body, :time, :place, :belonging, :image, :status, tag_ids: [])
  end
  
end
