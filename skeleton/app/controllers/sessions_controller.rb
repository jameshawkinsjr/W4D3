class SessionsController < ApplicationController
  before_action :require_logout, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if user
      login_user!(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
    end
    session[:session_token] = nil
    redirect_to cats_url
  end
end
