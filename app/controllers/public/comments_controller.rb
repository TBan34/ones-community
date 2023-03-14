class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    post = Post.find(params[:post_id])
    content = current_user.comments.new(comment_params)
    content.post_id = post.id
    if content.save
      post.create_notification_comment!(current_user, @comment.id)
      flash.now[:secondary] = "コメントを投稿しました"
    else
      redirect_to request.referer, danger: "コメントを入力してください"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:danger] = "コメントを削除しました"
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
