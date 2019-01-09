class SessionsController < ApplicationController
  before_action :check_login, only: :destroy
  before_action :print_user, only: :destroy
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Error: there was something wrong with your login information"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  def print_user
    flash[:success] = "#{current_user.username}'s session closed"
  end
  end
