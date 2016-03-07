class HomeController < ApplicationController
  def landing
    @feature_users = User.first(3)
  end
end
