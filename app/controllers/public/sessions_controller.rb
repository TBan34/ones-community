# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
    # サインアップ後の遷移先
    def after_sign_up_path_fot(resource)
      user_path(current_user.id)
    end
  
    # ログイン後の遷移先
    def after_sign_in_path_for(resource)
      root_path
    end
    
    # ログアウト後の遷移先
    def after_sign_out_path_for(resource)
      root_path
    end

    # ログイン時の入力情報
    def user_state
      @user = User.find_by(email: params[:user][:email])
      return if !@user
      if @user.valid_password?(params[:user][:password]) && !(@user.is_deleted == false)
        redirect_to new_user_registration_path
      end
    end
    
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
