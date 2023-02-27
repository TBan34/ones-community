class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # フラッシュメッセージにBootstrapのスタイルを適用
  add_flash_types :success, :info, :warning, :danger

  protected
    # サインアップ時の入力情報を追加（ユーザー名、氏名、電話番号）
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :name, :telephone_number])
    end
end
