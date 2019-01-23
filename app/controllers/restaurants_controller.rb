class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :edit, :update, :destroy, :user_restaurants]
  # GET /restaurants
  # GET /restaurants.json
  def index
    @hash = {}
    @buscar = params[:buscar]
    if @buscar==""
      @restaurants = Restaurant.all
    elsif @buscar
      @restaurants = Restaurant.where("title LIKE ?", "%#{@buscar}%")
    else
      @restaurants = Restaurant.all
      @restaurants.each do |item|
        @number = Comment.where(restaurant: item).average(:score)
        @hash[item.id] = @number
      end
      Hash[@hash.sort_by{|k, v| v}.reverse]
      @restaurants = []
      @hash.each_with_index do |val,index|
        flash[:success] = "#{@hash.values[0]}, #{@hash.values[1]}, #{@hash.values[2]}"
        @id = @hash.keys[index]
        @restaurant = Restaurant.find(@id)
        @restaurants.push(@restaurant)
      end
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def user_restaurants
    @restaurants = Restaurant.where(user: (User.find_by id: current_user.id))
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:title, :description, :user_id, :address, :telephone)
    end
end
