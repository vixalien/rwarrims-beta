class Location < ApplicationRecord
  belongs_to :loc, polymorphic: true
  has_one :location, as: :loc
	has_one :useragent, as: :ua
end
