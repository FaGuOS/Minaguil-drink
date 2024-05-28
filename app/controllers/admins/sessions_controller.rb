class Admins::SessionsController < Devise::SessionsController
  # GET /admin/login
  def new
    super
  end

  # POST /admin/login
  def create
    # 認証情報の取得
    email = params[:admin][:email]
    password = params[:admin][:password]

    # ユーザーの存在確認
    user = User.find_by(email: email)

    if user && user.admin? && user.valid_password?(password)
      # 管理者であることを確認し、パスワードが正しい場合

      # warden.authenticate! をスキップし、直接 sign_in する
      sign_in(resource_name, user)

      # super の 2 段階目から処理を開始する
      respond_with resource, location: after_sign_in_path_for(user)
    else
      # 認証失敗時の処理
      flash[:alert] = 'Invalid email or password.'
      redirect_to new_admin_session_path
    end
  end

  # DELETE /admin/logout
  def destroy
    super
  end

  protected

  # 管理者ユーザーかどうかをチェックするメソッド
  def check_admin
    user = User.find_by(email: params[:admin][:email])
    unless user&.admin?
      redirect_to admins_home_path, alert: "You are not authorized to access this page."
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
