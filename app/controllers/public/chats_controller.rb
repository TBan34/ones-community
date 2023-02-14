class Public::ChatsController < ApplicationController
  
  def create
    @room = Room.find_by(params[:chat][:room_id])
    @chat = Chat.new(user_id: current_user.id, room_id: @room.id, message: params[:chat][:message])
    if @chat.save
      redirect_to room_path(@room)
    else
      redirect_to room_path(@room)
    end
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:user_id, :room_id, :message)
  end
  
end
