class Admin::CommentsController < ApplicationController
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
