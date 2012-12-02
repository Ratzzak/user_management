class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    existing_user = User.find_by_email params[:user][:email]
    if existing_user.nil? 
      params[:user][:password] = PasswordUtils.create_random_password
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          UserMailer.signup(@user.email,params[:user][:password]).deliver
          format.html { redirect_to new_session_path, notice: 'Generated password has sent to your email id.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now.alert = "User with email id #{existing_user.email} already exits"
      render new_user_path
    end
  end
  

end
