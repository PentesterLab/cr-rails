class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    # don't authenticate the login and register pages as the user is not logged in
    return if request.path =~ /login/ or \
              request.path =~ /register/ or \
              request.path =~ /reset_password/ or \
              request.path =~ /password\/reset/

    return redirect_to login_path unless session[:user_id]
    @current_user = User.find(session[:user_id])
    return redirect_to login_path unless @current_user
  end
end
