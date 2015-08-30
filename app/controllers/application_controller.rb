class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  def encrypt(message)
    require 'digest'
    sha256 = Digest::SHA256.new
    digest = sha256.base64digest message
    return digest
  end
  
  def admin_required
    if user_active?
      if User.find_by_id(session[:user_id]).is_admin
        return true
      else
        flash[:message_navbar] = "Admin is required"
        flash[:success_navbar] = false
        redirect_to "/"
      end
    else
      signin_required
    end
  end
  
  def signin_required
    unless user_active?
      flash[:message_navbar] = "Sign-in is required"
      flash[:success_navbar] = false
      redirect_to "/" # flashing message that sign-in is required
    end
  end
  
  def signout_required
    if user_active?
      flash[:message_navbar] = "Sign-out is required"
      flash[:success_navbar] = false
      redirect_to "/" # flashing message that sign-in is required
    end
  end
  
  def user_active?
    !session[:user_id].nil? and !User.find_by_id(session[:user_id]).nil?
  end
  
  def set_navbar_category(category = "")
    session[:navbar_category] = category
  end
  
  def redirect_back
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to "/" # root_path
    end
  end

  def calc_page_num( pagenum, total_page )
    @start_page = 1 > ( pagenum - 2 ) ? 1 : ( pagenum - 2 )
    @end_page = @start_page + 4
    @end_page = total_page > @end_page ? @end_page : total_page
    @start_page = @end_page - 4
    @start_page = 1 > @start_page ? 1 : @start_page
    @pagenum = pagenum
  end
  
  def user_admin?
    user = User.find_by_id(session[:user_id])
    !user.nil? and user.is_admin
  end
end
