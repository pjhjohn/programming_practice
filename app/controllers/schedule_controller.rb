class ScheduleController < ApplicationController
  before_action -> {
    set_navbar_category "schedule"
  }
  def index
    params[:id] = nil

    @events = Event.all.order(start: :asc)
    current_event = nil
    today = Date.current.strftime("%F").gsub('-', '').to_i

    @events.each do |e|
      date = e.start.strftime("%F").split(' ').first.gsub('-', '').to_i
      if date >= today - 1
        current_event = e
        break
      end
    end

    event
    if current_event.nil?
      render :template => "schedule/event"
    else
      redirect_to "/pp2015/schedule/event/#{current_event.id}"
    end
  end

  # show event, returning rendered view
  def event
    @events = Event.all.order(start: :asc)
    @event = Event.find_by_id(params[:id])
  end

  # return event lists in json format
  def get_events
    event_response = Hash.new
    events = Event.all
    now = DateTime.now
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
        }) if now <= event.finish + 7.days
      end
      event_response[:success] = 1
    rescue Exception
      event_response[:success] = 0
    end
    render json: event_response
  end
end
