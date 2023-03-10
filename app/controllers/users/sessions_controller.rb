class Users::SessionsController < Devise::SessionsController

# ゲストユーザーのログイン/ログアウト
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: "ゲストユーザーでログインしました"
  end
  
  def guest_sign_out
    user = User.guest
    sign_out user
    redirect_to root_path, notice: "ゲストユーザーからログアウトしました" 
  end

end