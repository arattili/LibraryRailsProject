class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
  begin
    if(session[:user]["isadmin"]=="TRUE")
    @users = User.all
    elsif (session[:user]["id"])
    @users = User.where(id: session[:user]["id"])
    end
    rescue 
    render "error"
     else
    render "index"
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end
    # GET /users/login
  def login
    @user = User.new
  end

  # GET /users/1/edit
  def edit

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @password = params[:password]
    @user.password = @password

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  class BookedRoom
    attr_accessor :name, :time
    @name=""
    @time=""
  end

  def error
  end



  def myRooms
    @bookedRooms = getRooms
    if(@bookedRooms=="error")
      render "error"
    else
      render "myRooms"
    end


  end

  def getRooms
    begin
    if(session[:user]) 
      @bookings = Booking.where(userid: session[:user]["id"]).as_json
      @bookedRooms=[]
      @bookings.each do |r|
        @temp = BookedRoom.new
        @temp.name=Room.find(r["roomid"]).name
        @temp.time= r["time_date"]
        @bookedRooms.push(@temp)
      end
    return @bookedRooms
    else
      return "error"  
    end 
    rescue 
    return "error"
    else
    return @bookedRooms
    end

  end





  def loginTry
    @email = params[:email]
    @password = params[:password]
    @user = User.find_by_email(@email)
    if(@password == @user.password)
      session[:user] = @user
      session[:exists] = true
      @bookedRooms = getRooms
      render "myRooms"
    else
      session.clear
      render html: '<div>Incorrect login</div>'.html_safe
     end
  end

  def logout
    session.clear
    render "logout"
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @password = params[:password]
    @user.password = @password
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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        if(session[:user]["isadmin"]=="TRUE")
        @user = User.find(params[:id])
      else
        @user = User.find(session[:user]["id"])
      end
    rescue
      render "error"
    else
    end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :fname, :lname, :isadmin, :pers)
    end
end
