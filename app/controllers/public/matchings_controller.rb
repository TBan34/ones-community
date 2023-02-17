class Public::MatchingsController < ApplicationController
  
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer, info: "マッチングしました"
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer, danger: "マッチングを解除しました"
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
  private
  
  def matching_params
    params.require(:matching).permit(:user_id)
  end
  
end
