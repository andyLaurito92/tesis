

class Device < NetworkElement
	
	def self.uri_resource
		'http://127.0.0.1:8181/onos/v1/devices/'
	end

	def self.key_name_in_response
		'devices'
	end

=begin
devices is an array of elements of this kind
{
	"id"=>"of:0000000000000003", 
	"type"=>"SWITCH", 
	"available"=>true, 
	"role"=>"MASTER", 
	"mfr"=>"Nicira, Inc.", 
	"hw"=>"Open vSwitch", 
	"sw"=>"2.5.0", 
	"serial"=>"None", 
	"chassisId"=>"3", 
	"annotations"=>{
		"managementAddress"=>"127.0.0.1", 
		"protocol"=>"OF_13", 
		"channelId"=>"127.0.0.1:59170"
		}
}
=end
	def initialize(json)
		@json_representation=json
	end

	def transform_to_pdm_representation
		Device.increase_quantity_in_one
		"Atomic
	            {
	            Name = Router#{Device.quantity}
	            Ports = 2 ; 1
	            Path = PhaseI/Router.h
	            Description = In0: Incomming packetsInN: Outgoing packets from a single flowDemultiplexes a single packet flow in N input output streams.Each output stream contains packets belonging to a single flow identifier.
	            Graphic
	                {
	                Position = #{-9975 + 750 * (Device.quantity-1)} ; -8505
	                Dimension = 600 ; 675
	                Direction = Down
	                Color = 15
	                Icon = %datanetworks%router.jpg
	                }
	            Parameters
	                {
	                }
	            }
	            "
	end


end