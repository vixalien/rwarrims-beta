class Attendance < ActiveRecord::Base
	belongs_to :employee
	has_one :location, as: :loc
	has_one :useragent, as: :ua
end