class TimetableController < ApplicationController
	before_action :authenticate_user!

	def new
		@time_slots = current_user.time_slots
	end
end
