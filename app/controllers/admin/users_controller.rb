class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :prefecture, :municipality, :telephone_number, :display_name, :self_introduction, :profile_image)
  end
    
end
