class Schedule < ActiveRecord::Base
  belongs_to :event
  belongs_to :participation

  def self.auto_create_by_event(event)
  	event.period.times do |i|
  		if event.start_time + (i * 7).day > Time.now
	  		Schedule.create!(
	  			event: event,
	  			start_datetime: event.start_time + ( i * 7 ).day)
  		end
  	end
  end
end
