class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_unauthenticated_user
  #before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  
  def redirect_unauthenticated_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "You must be signed in to access this page."
    end
  end
  def block_unblock
    user_id = params[:user_id]
    puts "..........................My Id............###############//////////////////"
    puts params[:user_id]
    status = params[:status]

    # Find the user by ID
    user = User.find(user_id)

    # Update the user's status
    user.update(status: status)

    # Redirect or render as needed
    redirect_to users_path, notice: "User status updated successfully."
  end
  

  def delete_selected
    # Implement logic to delete selected users
  end
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :status)
    end
end
