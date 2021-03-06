class ParticipationsController < ApplicationController
	before_action :set_participation, only:[:show, :edit, :update, :destroy]

	def index
		@participations = Participation.all
	end

	def new
		@participation = Participation.new
	end

	def create
		@participation = Participation.new(status: participation_params[:status])
		@event = Event.find(params[:event_id])
		@participation.event_id = params[:event_id]
		@participation.user_id = @event.mentor_id

		if @participation.save
			redirect_to events_path, notice: "You are registered!"
		else
			render action: 'new'
		end
	end

	def show
	end

	private
	def participation_params
		params.require(:participation).permit(:status, :event_id)
	end

	def set_participation
		@participation = Participation.find(params[:event_id])
	end
end
