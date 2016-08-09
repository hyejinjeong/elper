class TimeSlotsController < ApplicationController
	before_action :authenticate_user!

	def manage_slots
		data = JSON.parse(params[:slots_data]) if params[:slots_data].present?
		sanitized_data = TimeSlot.sanitize_data(data) if data

		if sanitized_data.present?
			current_user.time_slots.destroy_all
			sanitized_data.each do |sanitized_datum|
				TimeSlot.create!(
								user: current_user, 
								start_hour_and_min: sanitized_datum["start_hour_and_min"], 
								end_hour_and_min: sanitized_datum["end_hour_and_min"],
								wday: sanitized_datum["wday"])
			end
		end
		
		redirect_to new_timetable_path
	end
end
