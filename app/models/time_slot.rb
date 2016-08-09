class TimeSlot < ActiveRecord::Base
	validates_presence_of :user_id, :wday, :start_hour_and_min, :end_hour_and_min
	validate :hour_and_min_format
	validate :overlap

	belongs_to :user

	enum wday: { sunday: 0, monday: 1, tuesday: 2, wednesday:3, thursday: 4, friday: 5, saturday: 6 }

	scope :between, -> (start_hour_and_min, end_hour_and_min) { where('time_slots.end_hour_and_min > ? AND time_slots.start_hour_and_min < ?', start_hour_and_min, end_hour_and_min) }
	scope :by_wday, -> (wday) { where(wday: TimeSlot.wdays[wday]) }

	def hour_and_min_format
		[start_hour_and_min, end_hour_and_min].each do |hour_and_min|
			hour = hour_and_min / 100
			min = hour_and_min % 100

			if hour < 0 || min < 0 || hour > 24 || min > 59
				errors.add(:hour_and_min, "잘못된 시간정보입니다.")
				return false 
			end
		end
	end

	def overlap
		if user.time_slots.by_wday(wday).between(start_hour_and_min, end_hour_and_min).present?
			errors.add(:hour_and_min, "유저가 가진 타임슬롯이랑 겹치는 시간이 존재합니다.")
		end
	end

	def self.sanitize_data(raw_data)
		grouped_data = raw_data.group_by{|datum| datum["wday"]}
		sanitized_data = []

		grouped_data.keys.each do |wday|
			wday_data = grouped_data[wday].sort_by{|datum| datum["start_hour_and_min"]}
			
			if wday_data.present?
				start_hour_and_min = wday_data[0]["start_hour_and_min"]
				end_hour_and_min = wday_data[0]["end_hour_and_min"]

				wday_data[1..-1].each_with_index do |datum, index|
					if end_hour_and_min < datum["start_hour_and_min"]
						sanitized_data << { "wday" => wday, "start_hour_and_min" => start_hour_and_min, "end_hour_and_min" => end_hour_and_min }
						start_hour_and_min = datum["start_hour_and_min"]
					end

					end_hour_and_min = datum["end_hour_and_min"]
				end

				sanitized_data << data = { "wday" => wday, "start_hour_and_min" => start_hour_and_min, "end_hour_and_min" => end_hour_and_min }					
			end
		end

		return sanitized_data
	end
end
