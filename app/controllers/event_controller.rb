class EventController < ApplicationController
  before_filter :admin_required
  before_filter -> {
    set_navbar_category "admin"
  }
  def index
    render :template => "event/read"
  end
  
  def read
  end

  def new
  end
  
  def edit
  end

  def create
    event = Event.new(
      title: params[:title],
      body:  params[:body],
      klass: params[:klass],
      start: Date.strptime(params[:start], '%s'),
      finish: Date.strptime(params[:finish], '%s')
    )
    event.save
    event.url = "#{event.url}/#{event.id}"
    event.save
    redirect_to "/admin/event"
  end

  def update
  end

  def delete
    if is_admin? and params[:id].present?
      
    end
    redirect :back
  end
end
