class Event < ActiveRecord::Base
	validates_presence_of :mentee_id, :mentor_id
	validate :select_time_between
	has_many :schedules
	belongs_to :mentee, class_name: "User"
	belongs_to :mentor, class_name: "User"

	
	before_validation do
		unless mentee
			self.mentee = User.create!(
							email: "#{User.last.id}@mentee.com",
							password: "#{User.last.id * 100000}",
							password_confirmation: "#{User.last.id * 100000}",
							category: :mentee
						)
		end
	end

	before_save do
		if self.start_time.present?
			Schedule.auto_create_by_event(self)
		end
	end

	def select_time_between
		if end_time.present?
			unless end_time > start_time
				errors.add(:select_time, "잘못된 시간정보입니다.")
			end
		end
	end
end
