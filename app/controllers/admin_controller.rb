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