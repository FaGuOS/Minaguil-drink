module Admins
  class HomesController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only

    def home
      redirect_to admins_dashboard_index_path
    end

    private

    def admin_only
      unless current_user&.admin?
        redirect_to root_path, alert: 'You do not have access to this section.'
      end
    end
  end
end
