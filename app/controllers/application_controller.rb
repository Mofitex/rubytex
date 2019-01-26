class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def check_login
    if !session[:user_id]
      flash[:error] = "You need to log-in to access this route"
      #render plain: "You need to login to access this route".inspect
      redirect_to root_path
    end
  end
  def check_admin
    if current_user.admin!=true
      flash[:error] = "You need to be admin to access this route"
      redirect_to root_path
    end
  end
  def check_owner
    @user = User.find(params[:id])
    if current_user==@user || current_user.admin==true
    else
      flash[:error] = "You need to be admin to access this route"
      redirect_to root_path
    end
  end

  helper_method :current_user
  private

  def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
