class CreditsController < ApplicationController
  before_filter -> {
    set_navbar_category "credits"
  }
  def index
  end
end
