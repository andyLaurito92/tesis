"An ONOS representation of a host"
class Host < NetworkElement
	
	def self.quantity
		@@quantity	
	end

	def self.increase_quantity_in_one
		@@quantity ||= 0
		@@quantity += 1
	end

=begin
This is the info that represents a host. This info is provided by /devices. /hosts gives
info that, besides its usefull, is not something that can be used for the pdm build.
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
		        Name = FelixServer#{@my_number}
		        Ports = 0 ; 1
		        Path = PhaseI/FelixServer.h
		        Description = Generates jobs. Distribution for the rate and jobSize are retrieved from the Flows assigned to this server
		        Graphic
		            {
		            Position = #{-9975 + 750 * (@my_number - 1)} ; -10285
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