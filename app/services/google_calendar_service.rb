class GoogleCalendarService
  Calendar = Google::Apis::CalendarV3

  def initialize(user)
    @service = Calendar::CalendarService.new
    @service.authorization = user.google_access_token
  end

  def list_events
    calendar_id = 'primary'
    @service.list_events(calendar_id)
  end

  def create_event(event_details)
    event = Google::Apis::CalendarV3::Event.new(
      summary: event_details[:summary],
      location: event_details[:location],
      description: event_details[:description],
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event_details[:start][:date_time],
        time_zone: event_details[:start][:time_zone]
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event_details[:end][:date_time],
        time_zone: event_details[:end][:time_zone]
      ),
      attendees: event_details[:attendees].map do |attendee|
        Google::Apis::CalendarV3::EventAttendee.new(email: attendee[:email])
      end
    )

    puts "Event Details: #{event.to_json}"

    calendar_id = 'primary'
    @service.insert_event(calendar_id, event)
  end
end