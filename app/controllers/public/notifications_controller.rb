class Public::NotificationsController < ApplicationController
  before_action :is_notification_theirs?, only: [:index]
  
  # ユーザー詳細画面におけるユーザーIDを基に、当該ユーザーの通知一覧を表示
  # 通知一覧を開いた際に、これまでの通知は確認されたものとする
  def index
    if params[:receiver_id]
      @notifications = User.find_by(id: params[:receiver_id]).passive_notifications.order(created_at: :desc).page(params[:page])
      @notifications.where(checked: false).each do |notification|
        notification.update(checked: true)
      end
    end
  end

  private
    def notification_params
      params.require(:notification).permit(:receiver_id)
    end
    
    # 本人以外が通知を閲覧できないよう制限
    def is_notification_theirs?
      @user = User.find_by(id: params[:receiver_id])
      user_id = @user.id
      unless user_id == current_user.id
        redirect_to root_path
      end
    end
end
