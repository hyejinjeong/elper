class Event < ActiveRecord::Base
	validates_presence_of :mentee_id, :mentor_id
	validate :select_time_between
	has_many :schedules
	belongs_to :mentee, class_name: "User"
	belongs_to :mentor, class_name: "User"

	scope :upcoming, -> (start_datetime) { where( 'Time.now < ?', start_datetime) }

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
		schedules = Schedule.where(event: self)
		# schedules.upcoming(schedules.start_datetime).destroy_all
		Schedule.auto_create_by_event(self)
	end

	def select_time_between
		if end_time.present?
			unless end_time > start_time
				errors.add(:select_time, "잘못된 시간정보입니다.")
			end
		end
	end
end
