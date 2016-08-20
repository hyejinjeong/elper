class ParticipationsController < ApplicationController
	def index
		@participations = Participation.all
	end

	def new
		@participation = Participation.new
		@event = Event.find(params[:event_id])
		@user = @event.mentor
	end

	def create
		@participation = Participation.new(status: participation_params[:status])
		@participation.event_id = params[:event_id]
		@participation.user_id = @user_id

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
end
