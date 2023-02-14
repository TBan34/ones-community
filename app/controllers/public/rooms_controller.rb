class Public::RoomsController < ApplicationController
  
  def create
    @room = Room.create(room_params)
    @user_room_1 = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @user_room_2 = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end
  
  def index
    @current_user_room = current_user.user_rooms
    myRoomIds = []
    @current_user_room.each do |user_room|
      myRoomIds << user_room.room.id
    end
    @another_user_room = UserRoom.where(room_id: myRoomIds).where.not(user_id: current_user.id).order(created_at: :desc)
  end
  
  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chat = Chat.new(room_id: params[:id])
      @chats = @room.chats
      @user_rooms = @room.user_rooms
    else
      redirect_to request.referer
    end
  end
  
  private
  
  def room_params
    params.require(:room).permit(:post_id)
  end
  
end
