class MainController < ApplicationController
  before_action -> {
    set_navbar_category "home"
  }
  def index
    if !session[:user_id].nil? and User.find_by_id(session[:user_id]).nil?
      reset_session # TODO : needs to be examined if this is proper logic
    end
    @announcements = Post.where(is_announcement: true).limit(5).order(created_at: :desc)
  end
end