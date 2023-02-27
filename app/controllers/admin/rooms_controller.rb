class Admin::RoomsController < ApplicationController
  def index
    @rooms = Room.order(created_at: :desc).page(params[:page])
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats
    @user_rooms = @room.user_rooms
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
