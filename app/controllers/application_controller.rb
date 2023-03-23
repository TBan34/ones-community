class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :is_admin_login?

  # リダイレクト時のフラッシュメッセージにBootstrapのスタイルを適用
  add_flash_types :success, :info, :warning, :danger, :secondary

  protected
    # サインアップ時の入力情報を追加（ユーザー名、氏名、電話番号）
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :name, :telephone_number])
    end
  
    # 管理者以外が管理者URLを閲覧できないよう制限
    def is_admin_login?
      request.fullpath.include?("/admin")
    end
end
