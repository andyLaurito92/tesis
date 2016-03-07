class PhysicalHost < Host

	#require_relative '../addresses/NullAddress'

	@address = NullAddress.new()

	def initialize(address)
		@address = address
	end

	def address
		@address
	end
end