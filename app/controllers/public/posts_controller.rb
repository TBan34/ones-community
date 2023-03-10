class Public::PostsController < ApplicationController
  before_action :is_post_user?, only:[:edit, :update, :destroy]
  
  def new
    @post = Post.new
  end
  
  # 投稿時にTag情報を含める
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag = Tag.find(params[:post][:tag_ids])
    @post.tags << tag
    if @post.save
      redirect_to posts_path, success: "投稿しました"
    else
      render :new
    end
  end
  
  # 投稿データからステータスが公開でアクティブなユーザを取得、タグ検索用にtagsも結合
  def index
    @posts = Post.list(params[:tag_id], params[:page], params[:user_id])
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    
    # 他のユーザーが非公開（下書き）の投稿を閲覧できないよう制限
    if @post.status_private? && @user != current_user
      redirect_to posts_path
    end
    
    # マッチング・チャットルームの作成
    @user_rooms = UserRoom.eager_load(:room).where(user_id: [current_user.id, @user.id]).where(room: {post_id: @post.id})
    # 投稿に対して投稿者・マッチングユーザーのチャットルームが存在する場合、「チャットへ」を表示
    if @user_rooms.exists?(user_id: current_user.id)
      @is_room = true
      @room_id = @user_rooms.find_by(user_id: current_user.id).room_id
    # 投稿に対して投稿者・マッチングユーザーのチャットルームが存在しない場合、「マッチング済（チャットを始める）」を表示
    else
      @is_room = false
      @room = Room.new
      @user_room = UserRoom.new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    tag = Tag.find(params[:post][:tag_ids])
    
    tag_data = @post.post_tags.find_or_create_by(post_id: @post.id) do |t|
      t.tag_id = tag.id
    end
    
      tag_data.update(tag_id: tag.id) unless tag_data.nil?
    
    if @post.update(post_params)
      redirect_to post_path(@post.id), success: "投稿を更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, danger: "投稿を削除しました"
    end
  end
  
  # 非公開（下書き）の投稿一覧
  def draft
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.status_private.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body, :time, :place, :belonging, :image, :status, tag_ids: [])
  end
  
  # 投稿者以外が投稿を編集できないよう制限
  def is_post_user?
    @post = Post.find(params[:id])
    user_id = @post.user.id
    unless user_id == current_user.id
      redirect_to root_path
    end
  end
  
end
