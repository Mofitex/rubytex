class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:index, :show, :edit, :update, :destroy, :profile]
  before_action :check_admin, only: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy, :profile]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    unless current_user.id==@user.id || current_user.admin==true
      flash[:error] = "You need to be admin to access this route"
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.admin
    else
      @user.admin = false
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to restaurants_path, notice: 'User was successfully created.' }
        format.json { render :profile, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    unless current_user.id==@user.id || current_user.admin==true
      flash[:error] = "You need to be admin to access this route"
      redirect_to root_path
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def profile
    @user = User.find(params[:user_id])
    unless current_user.id==@user.id || current_user.admin==true
      flash[:error] = "You need to be admin to access this route"
      redirect_to root_path
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :username, :admin)
    end
end
