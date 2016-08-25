class EventsController < ApplicationController
	before_action :authenticate_user!
	before_action :manager_only, only:[:new, :create, :destroy, :manage]
	before_action :manager_and_mentor_only, only:[:edit, :update]
	before_action :set_event, only: [:show, :edit, :update, :destroy, :manage]

	def new
		@event = Event.new()
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to events_path
		else
			render 'new'
		end
	end

	def show
		@time_slots = @event.mentee.time_slots
		@schedules = Schedule.where(event_id: @event.id)
		@participation = Participation.new
		
	end

	def manage
		@time_slots = @event.mentee.time_slots
	end

	def index
		# @events = Event.where(:user_id => current_user.id)
		@events = Event.all
		@events = Event.order(created_at: :desc)
	end

	def edit
		@time_slots = @event.mentee.time_slots
	end

	def update
		if current_user.manager
			if @event.update(event_params)
				redirect_to @event
			else
				render 'edit'
			end

		else current_user.mentor
			if @event.update(select_time_params)
				redirect_to @event
			else
				render 'edit'
			end
		end
	end

	def destroy
		@event.destroy
		redirect_to events_path
	end

	private
	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:title, :start_date, :period, :mentor_id, :mentee_id)
	end

	def select_time_params
		params.require(:event).permit(:start_time, :end_time)
	end
end
