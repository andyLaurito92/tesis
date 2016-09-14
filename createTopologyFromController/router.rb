

class Router < NetworkElement
	
	def self.quantity
		@@quantity	
	end

	def self.increase_quantity_in_one
		@@quantity ||= 0
		@@quantity += 1
	end

=begin
This is the info that represents a router
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
	def transform_to_pdm_representation
		"Atomic
	            {
	            Name = Router#{@my_number}
	            Ports = 2 ; 1
	            Path = PhaseI/Router.h
	            Description = In0: Incomming packetsInN: Outgoing packets from a single flowDemultiplexes a single packet flow in N input output streams.Each output stream contains packets belonging to a single flow identifier.
	            Graphic
	                {
	                Position = #{-9975 + 750 * (@my_number-1)} ; -8505
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