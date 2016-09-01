class AuthController < ApplicationController
  before_filter :signin_required, only: [:signout]
  before_filter :signout_required, only: [:signin]
  before_filter :admin_required, only: [:index, :signup]
  def index
  end

  def signup
    duplicate_user = User.where(username: params[:username]).take
    if duplicate_user.nil?
      new_user = User.new
      new_user.username = params[:username]
      new_user.realname = params[:realname]
      new_user.password = encrypt(params[:password])
      new_user.save
      redirect_to "/pp2015/auth", notice: "Succeed to signup"
    else
      redirect_to "/pp2015/auth", alert: "Failed to signup"
    end
  end

  def signin
    user = User.where(
      username: params[:username],
      password: encrypt(params[:password])
    ).take
    unless user.nil?
      session[:user_id] = user.id
      flash[:message_navbar] = "로그인 되었습니다"
      flash[:success_navbar] = true
    else
      flash[:message_navbar] = "로그인에 실패하였습니다"
      flash[:success_navbar] = false
    end
    redirect_to "/pp2015/", alert: "Watch it, mister!"
  end

  def signout
    reset_session
    redirect_to "/pp2015/"
  end
end
