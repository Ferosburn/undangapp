class HomeController < ApplicationController
  before_action :forbid_login_user
  
  def index
  end

end
