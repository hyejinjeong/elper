class EventsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_event, only: [:show, :edit, :update, :destroy]

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

	def show
		@event = Event.find(params[:id])
	end

	def index
		@events = Event.all
		@events = Event.order(created_at: :desc)
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])

		if @event.update(event_params)
			redirect_to @event
		else
			render 'edit'
		end
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:title, :start_date, :period)
	end

end
