class Public::NotificationsController < ApplicationController
  # ユーザー詳細画面におけるユーザーIDを基に、当該ユーザーの通知一覧を表示
  # 通知一覧を開いた際に、これまでの通知は確認されたものとする
  def index
    if params[:visited_id]
      @notifications = User.find_by(id: params[:visited_id]).passive_notifications.order(created_at: :desc).page(params[:page])
      @notifications.where(checked: false).each do |notification|
        notification.update(checked: true)
      end
    end
  end

  private
    def notification_params
      params.require(:notification).permit(:visited_id)
    end
end
