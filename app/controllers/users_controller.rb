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
  def bulk_update
  
    @selected_users=User.where(id:params.fetch(:user_ids,[]).compact)
    #binding.b
    if params[:commit]=="Block"
      @selected_users.update_all(status: :blocked)
      redirect_to users_path, notice: "User status updated successfully."
    elsif params[:commit]=="active"
      @selected_users.update_all(status: :active)
      redirect_to users_path, notice: "User status updated successfully."
    else
      redirect_to users_path, notice: "No user selected."
    end
  end

    

  #   @selected_users = User.where(id: params.fetch(:user_ids, []).compact)
  #   if params[:commit] == 'block'
  #     @selected_users.update_all(status: :blocked)
  #   elsif params[:commit] == 'unblock'
  #     # @selected_users.each { |u| u.active! }
  #     @selected_users.update_all(status: :active)
  #   end
  #   flash[:notice] = "#{@selected_users.count} users marked as #{params[:commit]}"
  #   redirect_to action: :index
  # end
  # def block_unblock
  #   user_id = params[:user_id]
  #   puts "..........................My Id............###############//////////////////"
  #   puts params[:user_id]
  #   status = params[:status]

  #   # Find the user by ID
  #   user = User.find(user_id)

  #   # Update the user's status
  #   user.update(status: status)

  #   # Redirect or render as needed
  #   redirect_to users_path, notice: "User status updated successfully."
  def bulk_delete
    @selected_users = User.where(id: params.fetch(:user_ids, []).compact)
    # puts "555555555555555555555555anything55555555555555555555555"
    # binding.b
    if @selected_users.empty?
      # Handle case where no users are selected
      flash[:alert] = "No users selected for deletion."
    else
      @selected_users.destroy_all
      flash[:notice] = "Selected users have been deleted successfully."
      
    end
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
