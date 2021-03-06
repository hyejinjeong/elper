class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user

	def show
	end

	def time_slots
	end

	def manage_slots
		data = JSON.parse(params[:slots_data]) if params[:slots_data].present?
		sanitized_data = TimeSlot.sanitize_data(data) if data

		if sanitized_data.present?
			@user.time_slots.destroy_all
			sanitized_data.each do |sanitized_datum|
				TimeSlot.create!(
								user: @user, 
								start_hour_and_min: sanitized_datum["start_hour_and_min"], 
								end_hour_and_min: sanitized_datum["end_hour_and_min"],
								wday: sanitized_datum["wday"])
			end
		end

		path = event_path(params[:event_id]) if params[:event_id].present?
		redirect_to path ? path : @user
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

end
