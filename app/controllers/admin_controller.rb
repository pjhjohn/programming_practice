class AdminController < ApplicationController
  before_filter :admin_required
  before_action -> {
    set_navbar_category "admin"
  }
  def index
  end
end