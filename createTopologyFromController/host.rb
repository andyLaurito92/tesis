"An ONOS representation of a host"
class Host < NetworkElement
	
	def self.uri_resource
		'http://127.0.0.1:8181/onos/v1/hosts/'
	end

	def self.key_name_in_response
		'hosts'
	end

=begin
hosts is an array of elements of this kind
{
	"id"=>"AE:15:BC:19:CB:3D/None", 
	"mac"=>"AE:15:BC:19:CB:3D", 
	"vlan"=>"None", 
	"ipAddresses"=>["10.0.0.3"], 
	"location"=>{
		"elementId"=>"of:0000000000000004", 
		"port"=>"1"
	}
}
=end
	def initialize(json)
		@json_representation=json
	end

	def transform_to_pdm_representation
		Host.increase_quantity_in_one
		"Atomic 
				{
		        Name = FelixServer#{Host.quantity}
		        Ports = 0 ; 1
		        Path = PhaseI/FelixServer.h
		        Description = Generates jobs. Distribution for the rate and jobSize are retrieved from the Flows assigned to this server
		        Graphic
		            {
		            Position = #{-9975 + 750 * (Host.quantity - 1)} ; -10285
		            Dimension = 450 ; 435
		            Direction = Right
		            Color = 15
		            Icon = %datanetworks%generator.png
		            }
		        Parameters
		            {
		            }
		        }
		        "
	end
end