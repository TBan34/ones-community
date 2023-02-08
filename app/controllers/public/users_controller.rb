class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to current_user
    end
  end
  
  def unsubscribe
  end
  
  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :prefecture, :municipality, :telephone_number, :display_name, :self_introduction, :profile_image)
  end
  
end
