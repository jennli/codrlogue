class HomeController < ApplicationController
  def landing
    @feature_users = User.where("image <> ''"); 
  end
end
