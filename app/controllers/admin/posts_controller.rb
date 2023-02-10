class Admin::PostsController < ApplicationController
  
  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def destroy
    
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body, :time, :place, :belonging, :image, tag_ids: [])
  end
  
end
