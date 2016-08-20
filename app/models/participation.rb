class Participation < ActiveRecord::Base
  belongs_to :event

  enum status: { attendance: 0, uncertain: 1, absence: 2}
end
