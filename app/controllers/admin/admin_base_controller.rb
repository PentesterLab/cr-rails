class Admin::AdminBaseController < ApplicationController
  before_action :is_admin


  protected

  def is_admin
    authenticate
    return redirect_to login_path unless @user  and @user.is_admin?
  end
end
