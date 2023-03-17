class Admin::RoomsController < ApplicationController
  def index
    @rooms = Room.order(created_at: :desc).page(params[:page])
    
    # 投稿に関連するチャット一覧
    if params[:post_id]
      @rooms = Room.where(post_id: params[:post_id]).order(created_at: :desc).page(params[:page])
    end
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats
    
    # 退会済ユーザーの情報を取得し、チャット画面上部に表示（最大２名）
    user_ids = @room.user_rooms.pluck(:user_id)
    users = User.where(id: user_ids).where(is_deleted: true)
    user_names = users.pluck(:display_name)
    if users.present?
      if users.count == 2
        flash.now[:info] = "#{user_names[0]}, #{user_names[1]}は退会済のユーザーです"
      else
        flash.now[:info] = "#{user_names[0]}は退会済のユーザーです"
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      redirect_to admin_rooms_path, danger: "ルームを削除しました"
    end
  end

  private
    def room_params
      params.require(:room).permit(:post_id)
    end
end
