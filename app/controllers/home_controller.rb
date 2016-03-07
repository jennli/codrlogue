class HomeController < ApplicationController
  def landing
    @feature_users = User.where(approved: true).first(3)
  end
end
