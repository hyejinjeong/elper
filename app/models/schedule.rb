class Schedule < ActiveRecord::Base
  belongs_to :event
  belongs_to :participation

  scope :upcoming, -> { where( 'start_datetime > ?', Time.now) }
  scope :past, -> { where( 'start_datetime < ?', Time.now) }

  def self.auto_create_by_event(event)
  	event.schedules.upcoming.destroy_all

  	event.period.times do |i|
  		event_day = event.start_time + (i * 7).day
  		if event_day > Time.now
	  		Schedule.create!(
	  			event: event,
	  			start_datetime: event_day)
  		end
  	end
  end
end
