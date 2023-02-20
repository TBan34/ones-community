class Public::ChatsController < ApplicationController
  
  # チャット通知を作成する際にuser_idが必要
  def create
    @chat = Chat.new(chat_params.merge({user_id: current_user.id}))
    if @chat.save
      @chat.create_notification_chat!(current_user)
      redirect_to room_path(params[:chat][:room_id])
    else
      redirect_to room_path(params[:chat][:room_id]), danger: "メッセージを入力してください"
    end
  end
  
  private
  
  def chat_params
    params.require(:chat).permit(:room_id, :message)
  end
  
end
