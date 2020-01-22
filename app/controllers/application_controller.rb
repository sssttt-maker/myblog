class ApplicationController < ActionController::Base
  before_action :ensure_domain
  FQDN = 'shu-engineer.com'
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_category

  def get_category
    @allCategories = Category.all
  end

  protected

  def ensure_domain
    return unless /\.herokuapp.com/ =~ request.host
    # 主にlocalテスト用の対策80と443以外でアクセスされた場合ポート番号をURLに含める
    port = ":#{request.port}" unless [80, 443].include?(request.port)
    redirect_to "#{request.protocol}#{FQDN}#{port}#{request.path}", status: :moved_permanently
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
