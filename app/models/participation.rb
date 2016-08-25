class Participation < ActiveRecord::Base
	belongs_to :schedule

	enum status: { attendance: 0, uncertain: 1, absence: 2}
end
