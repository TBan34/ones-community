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
    tag = Tag.find(params[:post][:tag_ids])

    tag_data = @post.post_tags.find_or_create_by(post_id: @post.id) do |t|
      t.tag_id = tag.id
    end

    tag_data.update(tag_id: tag.id) unless tag_data.nil?

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
