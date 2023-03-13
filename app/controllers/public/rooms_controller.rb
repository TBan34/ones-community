class Public::RoomsController < ApplicationController
  def create
    @room = Room.create(room_params)
    @user_room_1 = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @user_room_2 = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def index
    # 自分用のチャットルームにルームIDを紐付ける
    @current_user_room = current_user.user_rooms
    myRoomIds = []
    @current_user_room.each do |user_room|
      myRoomIds << user_room.room.id
    end
    # 上記のルームIDに紐づく全てのチャットルームを検索し、自分用を除くことで、相手用のチャットルームを一覧表示する
    @another_user_room = UserRoom.where(room_id: myRoomIds).where.not(user_id: current_user.id).order(created_at: :desc).page(params[:page])
  end

  def show
    @room = Room.find_by(id: params[:id])
    # 管理者によってルームが削除された際に、ユーザーが通知等からルームへ入れないよう制限（return行）
    return redirect_to request.referer unless @room.present?
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chat = Chat.new(room_id: params[:id])
      @chats = @room.chats
      @user_rooms = @room.user_rooms
    else
      redirect_to request.referer
    end
    
    # 退会済ユーザーの情報を取得し、チャット画面上部に表示（最大1名）
    user_ids = @user_rooms.pluck(:user_id)
    users = User.where(id: user_ids).where(is_deleted: true)
    if users.present?
      users.each do |user|
        flash.now[:info] = "#{user.display_name}は退会済のユーザーです"
      end
    end
  end

  private
    def room_params
      params.require(:room).permit(:post_id)
    end
end
