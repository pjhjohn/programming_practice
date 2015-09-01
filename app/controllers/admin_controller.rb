class AdminController < ApplicationController
  before_filter :admin_required
  before_action -> {
    set_navbar_category "admin"
  }
  def index
  end

  def members
    load_members params[:page_id]
    ## member detail 추가바람
  end

  def user_create
  end

  def create_user_do
    duplicate_user = User.where(username: params[:new_username]).take
    if duplicate_user.nil?
      new_user = User.new
      new_user.username = params[:new_username]
      new_user.password = encrypt(params[:password])
      new_user.realname = params[:new_name]
      new_user.save
      flash[:success] = "SUCCESS TO CREATE USER"
    else
      flash[:alert] = "FAILED TO CREATE USER : USERNAME ALREADY EXISTS"
    end
    flash[:create_user] = true
    redirect_to "/admin/user_create"
  end

  def user_modify
    if params[:id].nil?
      redirect_to "/"
    else
      unless User.find_by_id(params[:id]).nil?
        @user = User.find_by_id(params[:id])
      else
        redirect_to "/"
      end
    end
  end

  def modify_user_do
    if user_active? and !params[:id].nil?
      user = User.find_by_id(params[:id])
      duplicate_user = User.where(username: params[:new_username]).take
      if duplicate_user.nil? or user.username == params[:new_username]
        user.username = params[:new_username] if params[:new_username].present?
        user.password = encrypt(params[:password]) if params[:password].present?
        user.realname = params[:new_name] if params[:new_name].present?
        user.save
      end
      pagenum = ( User.all.count - user.id ) / 20 + 1
      redirect_to "/admin/members/" + pagenum.to_s
    else
      redirect_to "/"
    end
  end

  def user_make_admin
    user = User.find_by_id(params[:id])
    if user.nil?
      render :text => "fail"
    else
      user.is_admin = true
      user.save
      render :text => "success"
    end
  end

  def user_make_normal
    if user_active?
      user = User.find_by_id(params[:id])
      user.is_admin = false
      user.save
      render :text => "success"
    else
      render :text => "fail"
    end
  end

  def delete_user
    if user_active?
      User.find_by_id(params[:id]).destroy
      render :text => "success"
    else
      render :text => "fail"
    end
  end

  ## load member list ##
  def load_members(pagenum = nil, members_per_page = 20)
    pagenum = 1 if pagenum.nil?
    pagenum = pagenum.to_i
    @page = User.limit(members_per_page).offset(members_per_page*(pagenum-1)).order(id: :desc)

    # Calc Pages Number
    total_page = User.all.count / members_per_page + 1
    calc_page_num(pagenum, total_page)

    return @page.nil?? [] : @page
  end

  ## load member info ##
  def load_member_detail
  end
end