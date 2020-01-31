module EmployeesHelper
	def getPosition num
		getAllPositions.find_index num
	end
	def getPositionId num
		getAllPositions[num.to_i]
	end
	def getAllPositions
		["Field Officer",
		 "Senior Extensionist",
		 "M&E Officer",
		 "Finance Manager",
		 "Accountant",
		 "Driver",
		 "Executive Director",
		 "Pending"
		]
	end
	def getPositionOptions
		opts = []
		i = 0
		for pos in getAllPositions
			opts[i] = [pos, i]
			i+=1
		end
		opts
	end
	def getDepartment num
		getAllDepartments.find_index num
	end
	def getDepartmentId num
		getAllDepartments[num.to_i]
	end
	def getAllDepartments
		["Program",
		 "Finance",]
	end
	def getDepartmentOptions
		opts = []
		i = 0
		for pos in getAllDepartments
			opts[i] = [pos, i]
			i+=1
		end
		opts
	end
end
