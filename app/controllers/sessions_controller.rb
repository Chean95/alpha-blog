class SessionsController < ApplicationController

  def new

  end

  def create
    # render 'new'
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # saving the id in session which will be handled by the browser's cookies
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Username or password is invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end