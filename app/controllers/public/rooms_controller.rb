class Public::RoomsController < ApplicationController
  
  def create
    current_users_rooms = UserRoom.where(user_id: current_user.id)
    room = UserRoom.where(room_id: current_users_rooms, user_id: params[:user_id])
    
    if room.blank?
      room = Room.create
      UserRoom.create(user_id: current_user.id, room_id: room.id)
      UserRoom.create(user_id: params[:user_id], room_id: room.id)
    end
    
    redirect_to room_path(room)
    
  end
  
  def index
    
  end
  
  def show
    
  end
  
end
