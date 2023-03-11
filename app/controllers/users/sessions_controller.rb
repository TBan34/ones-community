class Users::SessionsController < Devise::SessionsController
  # ゲストユーザーのログイン/ログアウト
  def guest_sign_in
    guest_user = User.guest
    sign_in guest_user
    redirect_to posts_path, notice: "ゲストユーザーでログインしました"
  end

  def guest_sign_out
    guest_user = User.guest
    sign_out guest_user
    redirect_to root_path, notice: "ゲストユーザーからログアウトしました"
  end
end
