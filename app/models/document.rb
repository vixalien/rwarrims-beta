class Document < ActiveRecord::Base
	belongs_to :employee
	has_one_attached :attachment
end