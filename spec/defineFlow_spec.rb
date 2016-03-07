RSpec.describe 'DefinedFlow' do
  
	require 'require_all'

	require_all './flows'
	require_all './hosts'
	require_all './addresses'

	describe '#newFLow' do
		context 'Some or both of the host endpoints are not recieved' do
			it 'raise an DefinedFlowError exception' do
				expect { DefinedFlow.newFlow(nil,nil) }.to raise_error(DefinedFlowError,'You must provide a startingHost and endingHost to create a new DefinedFlow')
				expect { DefinedFlow.newFlow(nil,Host.new) }.to raise_error(DefinedFlowError,'You must provide a startingHost and endingHost to create a new DefinedFlow')
				expect { DefinedFlow.newFlow(Host.new,nil) }.to raise_error(DefinedFlowError,'You must provide a startingHost and endingHost to create a new DefinedFlow')
			end
		end	

		context 'Invalid hosts recieved' do
			it 'raise a DefinedFlowError when some of the hosts have no address' do
				expect { DefinedFlow.newFlow(Host.new,Host.new) }.to raise_error(DefinedFlowError,'Some of the hosts provided have not an address')
				expect { DefinedFlow.newFlow(Host.new,PhysicalHost.new(IP.new)) }.to raise_error(DefinedFlowError,'Some of the hosts provided have not an address')
				expect { DefinedFlow.newFlow(PhysicalHost.new(MAC.new),Host.new) }.to raise_error(DefinedFlowError,'Some of the hosts provided have not an address')
			end

			it 'raise a DefinedFlowError when host recieved does not exist' do
				expect { DefinedFlow.newFlow(PhysicalHost.new(MAC.new),PhysicalHost.new(IP.new)) }.to raise_error(DefinedFlowError,'Some of the hosts provided dont exist in the network')
			end
		end
	end

end
