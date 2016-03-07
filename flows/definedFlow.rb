class DefinedFlow 

	require_relative 'definedFlowError'

	def self.newFlow(startingHost,endingHost) 
		fail DefinedFlowError.new('You must provide a startingHost and endingHost to create a new DefinedFlow') if (startingHost == nil) || (endingHost == nil)
		fail DefinedFlowError.new('Some of the hosts provided have not an address') if (startingHost.address.isNullAddress) || (endingHost.address.isNullAddress)
	end	

end