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
  
  # Tag情報も併せて一覧表示
  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.page(params[:page]) : Post.status_public.order(created_at: :desc).page(params[:page])
    # マイページから過去の投稿一覧を表示（本人のみ）
    if params[:user_id]
      @posts = Post.status_public.where(user_id: params[:user_id]).order(created_at: :desc).page(params[:page])
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    
    # 他のユーザーが非公開（下書き）の投稿を閲覧できないよう制限
    if @post.status_private? && @user != current_user
      redirect_to posts_path
    end
    
    # 投稿詳細からマッチング後、「チャットを始める」ボタンを押すと、両者にチャットルームが作成される
    @current_user_room = UserRoom.where(user_id: current_user.id)
    @another_user_room = UserRoom.where(user_id: @user.id)
    # マッチングしている場合、チャットルームのリンクを表示する
    @current_user_room.each do |current_user|
      @another_user_room.each do |another_user|
        if current_user.room_id == another_user.room_id then
          @is_room = true
          @room_id = current_user.room_id
        end
      end
    end
    # マッチングしていない場合、チャットルームを作成する
    unless @is_room
      @room = Room.new
      @user_room = UserRoom.new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.user.id = current_user.id
    if @post.update(post_params)
      redirect_to post_path(@post.id), success: "投稿を更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.user.id = current_user.id
    if @post.destroy
      redirect_to posts_path, danger: "投稿を削除しました"
    end
  end
  
  # 非公開（下書き）の投稿一覧
  def draft
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.status_private.order(created_at: :desc).page(params[:page])
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
