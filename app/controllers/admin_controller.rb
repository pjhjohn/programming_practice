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
    pagenum = 0 if pagenum.nil?
    pagenum = pagenum.to_i
    @page = User.limit(members_per_page).offset(members_per_page*pagenum).order(id: :desc)
    return @page.nil?? [] : @page
  end

  ## load member info ##
  def load_member_detail
  end
end