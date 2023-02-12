class Public::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    post = Post.find(params[:post_id])
    content = current_user.comments.new(comment_params)
    content.post_id = post.id
    content.save
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
