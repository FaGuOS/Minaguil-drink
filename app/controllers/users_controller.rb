class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:exit, :good_bye]

  def exit
    # 退会画面の表示
  end

  def good_bye
    # ユーザーの退会処理
    current_user.destroy
    redirect_to root_path, notice: '退会処理が完了しました。'
  end
end
