class Public::ChatsController < ApplicationController
  
  def create
    @room = UserRoom.find(params[:chat][:room_id])
    @chat = Chat.new(user_id: current_user.id, room_id: @room.id, message: params[:chat][:message])
    if @chat.save
      redirect_to room_path(@room)
    else
      redirect_to room_path(@room)
    end
  end
  
end
