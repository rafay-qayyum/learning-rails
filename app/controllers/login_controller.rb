class LoginController < ApplicationController
  def new
    @user=User.new
  end
  def create
    @user=User.find_by(username: params[:username])
    if @user && @user[:password]==params[:password]
      session[:user_id]=@user.id
      redirect_to articles_path
    else
      redirect_to root_path, notice: "Invalid username or password."
    end
  end
  def destroy
    session[:user_id]=nil
    redirect_to root_path, notice: "You have successfully logged out."
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
