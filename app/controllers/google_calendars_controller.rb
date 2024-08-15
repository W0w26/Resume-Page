class GoogleCalendarsController < ApplicationController

  def index
    @events = GoogleCalendarService.new(current_user).list_events.items
  end

  def create
    start_time = params[:start_time]
    end_time = params[:end_time]

    if start_time.nil? && end_time.nil?
    event_details = {
      summary: params[:summary],
      location: params[:location],
      description: params[:description],
      start: {
        date_time: params[:start_time].to_datetime.iso8601,
        time_zone: 'Europe/Istanbul'
      },
      end: {
        date_time: params[:end_time].to_datetime.iso8601,
        time_zone: 'Europe/Istanbul'
      },
      attendees: params[:attendees].split(',').map { |email| { email: email.strip } },
    }

    GoogleCalendarService.new(current_user).create_event(event_details)
    redirect_to google_calendars_path, notice: 'Event was successfully created.'
    else
      redirect_to google_calendars_path, alert: 'Every information is required to create an event.'
    end
  end
end