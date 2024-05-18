class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top, :home, :about]
  def top
  end

  def about
  end

  def home
  end
end
