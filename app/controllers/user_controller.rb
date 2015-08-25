class UserController < ApplicationController
  before_action :signin_required
  before_action -> {
    set_navbar_category "userinfo"
  }
  def index
    redirect_back
  end
  
  # session[:user_id] & params[:id] MUST EXIST
  def info
    if params[:id].nil?
      redirect_to "/"
    end
  end
  
  def change_username
    if user_active?
      user = User.find_by_id(session[:user_id])
      if !user.nil? and user.password == encrypt(params[:password])
        if User.where(username: params[:new_username]).take.nil?
          user.username = params[:new_username]
          user.save
          flash[:success] = "SUCCESS TO CHANGE USERNAME"
        else
          flash[:alert] = "NEW USERNAME DUPLICATES TO ANOTHER'S"
        end
      else
        flash[:alert] = "FAILED TO CHANGE USERNAME"
      end
      flash[:change_username] = true
      redirect_to "/user/info/#{session[:user_id]}"
    else
      redirect_to "/"
    end
  end
  
  def change_password
    if user_active?
      user = User.find_by_id(session[:user_id])
      if !user.nil? and user.password == encrypt(params[:old_password])
        user.password = encrypt(params[:new_password])
        user.save
        flash[:success] = "SUCCESS TO CHANGE PASSWORD"
      else
        flash[:alert] = "FAILED TO CHANGE PASSWORD"
      end
      flash[:change_password] = true
      redirect_to "/user/info/#{session[:user_id]}"
    else
      redirect_to "/"
    end
  end
  
  def change_email
    if user_active?
      user = User.find_by_id(session[:user_id])
      if !user.nil? and user.password == encrypt(params[:password])
          user.email = params[:new_email]
          user.save
          flash[:success] = "SUCCESS TO CHANGE EMAIL"
      else
        flash[:alert] = "FAILED TO CHANGE EMAIL"
      end
      flash[:change_email] = true
      redirect_to "/user/info/#{session[:user_id]}"
    else
      redirect_to "/"
    end
  end
end