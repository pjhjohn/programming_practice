class EventController < ApplicationController
  before_filter :admin_required
  before_filter -> {
    set_navbar_category "admin"
  }
  def index
    redirect_to "/admin"
  end
  
  def new
  end
  
  def edit
    if params[:id].nil?
      redirect_to :back
    elsif Event.find_by_id(params[:id]).nil?
      redirect_to :back
    else
      @event = Event.find_by_id(params[:id])
    end
  end

  def remove
    if params[:id].nil?
      redirect_to :back
    elsif Event.find_by_id(params[:id]).nil?
      redirect_to :back
    else
      @event = Event.find_by_id(params[:id])
    end
  end

  def create
    event = Event.new(
      title: params[:title],
      body:  params[:body],
      klass: params[:klass],
      start: DateTime.strptime(params[:start], '%s'),
      finish: DateTime.strptime(params[:finish], '%s')
    )
    event.save
    event.url = "#{event.url}/#{event.id}"
    event.save
    redirect_to "/admin/event"
  end

  def update
    if params[:id].present?
      event2update = Event.find_by_id(params[:id])
      unless event2update.nil?
        event2update.title = params[:title] if params[:title].present?
        event2update.body  = params[:body]  if params[:body].present?
        event2update.klass = params[:klass] if params[:klass].present?
        event2update.start = DateTime.strptime(params[:start], '%s') if params[:start].present?
        event2update.finish = DateTime.strptime(params[:finish], '%s') if params[:finish].present?
        event2update.save
        redirect_to "/schedule/event/#{params[:id]}", notice: "Successfully updated"
      else
        redirect_to "/schedule", alert: "No such event exists"
      end
    else
      redirect_to "/schedule", alert: "Failed to update event : No such ID exists"
    end
  end

  def delete
    if params[:id].present?
      event2delete = Event.find_by_id(params[:id])
      unless event2delete.nil?
        event2delete.destroy
        redirect_to "/schedule", notice: "Successfully deleted"
      else
        redirect_to "/schedule", alert: "No such event exists"
      end
    else
      redirect_to "/schedule", alert: "Failed to update event : No such ID exists"
    end
  end
end
