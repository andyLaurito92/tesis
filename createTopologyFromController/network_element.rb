class NetworkElement

	def initialize(json)
		@my_number = self.class.increase_quantity_in_one
		@json_representation=json
	end

	def id
		@json_representation['id']
	end

	def representation
		@json_representation
	end

	def my_number
		@my_number
	end

end