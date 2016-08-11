class EventsController < ApplicationController
	before_action :authenticate_user!

	def new
		@time_slots = current_user.time_slots
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@event.user_id = current_user
		if @event.save
			redirect_to events_path
		else
			render 'new'
		end
	end

	def index
		@events = Event.all
		@events = Event.order(created_at: :desc)
	end

	private
	def event_params
		params.require(:event).permit(:title, :start_date, :period)
	end

end
