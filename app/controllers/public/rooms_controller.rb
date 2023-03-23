class Public::RoomsController < ApplicationController
  before_action :is_participant_themselves?, only: [:show]

  def create
    @room = Room.create(room_params)
    @current_user_room = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @post_user_room = UserRoom.create(user_id: @room.post.user_id, room_id: @room.id)
    redirect_to room_path(@room.id)
  end

  def index
    room_ids = UserRoom.where(user_id: current_user.id).pluck(:room_id)
    @post_user_room = UserRoom.where(room_id: room_ids).where.not(user_id: current_user.id).order(created_at: :desc).page(params[:page])
  end

  def show
    # 投稿からルームに遷移する際にfindではエラーが出るため、find_byメソッドを使用
    @room = Room.find_by(id: params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chat = Chat.new(room_id: params[:id])
      @chats = @room.chats
      @user_rooms = @room.user_rooms
    else
      redirect_to request.referer
    end

    # 退会済ユーザーの情報を取得し、ルーム画面上部に表示（最大1名）
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

    # 当事者以外がルームに入れないよう制限
    def is_participant_themselves?
      @room = Room.find(params[:id])
      @user_rooms = @room.user_rooms
      participant_ids = @user_rooms.pluck(:user_id)
      unless participant_ids.include?(current_user.id)
        redirect_to root_path
      end
    end
end
