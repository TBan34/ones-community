class Public::NotificationsController < ApplicationController
  
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
