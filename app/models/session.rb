class Session < ApplicationRecord
  has_one :location, as: :loc
	has_one :useragent, as: :ua
	belongs_to :employee
end
