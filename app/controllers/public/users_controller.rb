class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update
      redirect_to current_user
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :prefecture, :municipality, :telephone_number, :display_name, :self_introduction)
  end
  
end
