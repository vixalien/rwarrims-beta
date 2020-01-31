module LeavesHelper
	def getCategory num
		getAllCategorys.find_index num
	end
	def getCategoryId num
		getAllCategorys[num.to_i]
	end
	def getAllCategorys
		["Annual",
		 "Sick",
		 "Maternity",
		 "Bereavement",
		 "Absence",
		 "Lateness"]
	end
	def getCategoryOptions
		opts = []
		i = 0
		for pos in getAllCategorys
			opts[i] = [pos, i]
			i+=1
		end
		opts
	end
end
