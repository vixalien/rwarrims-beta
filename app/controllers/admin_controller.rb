class AdminController < ApplicationController
	before_action :set_admin
	def set_admin
		@admin = true
	end
	@controller_name = "a"
	layout 'admin'
end