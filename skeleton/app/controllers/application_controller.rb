class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to cats_url
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def require_logout
    redirect_to cats_url if logged_in?
  end
end
