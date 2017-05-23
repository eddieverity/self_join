class UsersController < ApplicationController
  def login

  end

  def submit_login
    @user = User.find_by('email = ?', params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_name] = @user.name
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end

  end

  def new
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect_to '/'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def register
  end

  def logout
    reset_session
    redirect_to "/users/login"
  end
private
  def user_params
    params.require(:user).permit(:email,:name,:password,:password_confirmation)
  end

end
