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
          flash[:change_username_success] = true
          flash[:change_username_body] = "SUCCESS TO CHANGE USERNAME"
        else
          flash[:change_username_success] = false
          flash[:change_username_body] = "NEW USERNAME DUPLICATES TO ANOTHER'S"
        end
      else
        flash[:change_username_success] = false
        flash[:change_username_body] = "FAILED TO CHANGE USERNAME"
      end
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
        flash[:change_password_success] = true
        flash[:change_password_body] = "SUCCESS TO CHANGE PASSWORD"
      else
        flash[:change_password_success] = false
        flash[:change_password_body] = "FAILED TO CHANGE PASSWORD"
      end
      redirect_to "/user/info/#{session[:user_id]}"
    else
      redirect_to "/"
    end
  end
  
  def change_username_form
  end
  
  def change_password_form
  end
end
