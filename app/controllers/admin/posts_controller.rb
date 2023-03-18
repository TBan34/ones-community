class Admin::PostsController < ApplicationController
  # 投稿データからステータスが公開でアクティブなユーザを取得、タグ検索用にtagsも結合
  def index
    @posts = Post.list(params[:tag_id], params[:page], params[:user_id])
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
    if @post.update(post_params) && @post.save_tags(params[:post][:tag])
      if @post.status_public?
        redirect_to admin_post_path(@post.id), success: "投稿を更新しました"
      else
        redirect_to admin_posts_path, secondary: "投稿を非公開（下書き）にしました"
      end
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
      params.require(:post).permit(:user_id, :title, :body, :since_when, :at_where, :for_playing, :image)
    end
end
