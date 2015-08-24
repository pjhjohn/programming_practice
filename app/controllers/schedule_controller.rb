class ScheduleController < ApplicationController
  before_filter :signin_required, only: [:index, :event]
  before_action -> {
    set_navbar_category "schedule"
  }
  def index
    params[:id] = nil
    event
    render :template => "schedule/event"
  end

  # show event, returning rendered view
  def event
    @events = Event.all.order(created_at: :desc)
    @event = Event.find_by_id(params[:id])
  end

  # return event lists in json format
  def get_events
    event_response = Hash.new
    events = Event.all
    begin
      event_response[:result] = Array.new
      events.each do |event|
        event_response[:result].push({
          :id    => event.id,
          :title => event.title,
          :url   => event.url,
          :class => event.klass,
          :start => event.start.to_datetime.strftime('%Q').to_i,
          :end   => event.finish.to_datetime.strftime('%Q').to_i
        })
      end
      event_response[:success] = 1
    rescue Exception
      event_response[:success] = 0
    end
    render json: event_response
  end
end
