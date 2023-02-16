class Public::UsersController < ApplicationController
  before_action :is_login_user?, only:[:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to current_user, success: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end
  
  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, danger: "退会しました"
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :prefecture, :municipality, :telephone_number, :display_name, :self_introduction, :profile_image)
  end
  
  def is_login_user?
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to root_path
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end
  
end
