class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end
  
  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
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
  
  def confirm
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body, :time, :place, :belonging, :image, tag_ids: [])
  end
  
end
