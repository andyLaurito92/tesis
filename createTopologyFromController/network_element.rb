class NetworkElement

	def self.quantity
		@@quantity	
	end

	def self.increase_quantity_in_one
		@@quantity ||= 0
		@@quantity += 1
	end

end