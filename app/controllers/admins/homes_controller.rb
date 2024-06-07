class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!
  #before_action :admin_only

  def home
    redirect_to admins_home_path
  end

  #private

  #def admin_only
  #  unless current_user&.admin?
  #    redirect_to root_path, alert: 'You do not have access to this section.'
  #  end
  #end
end

