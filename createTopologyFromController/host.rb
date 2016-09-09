"An ONOS representation of a host"
class Host
	def self.uri_resource
		'http://127.0.0.1:8181/onos/v1/hosts/'
	end

	def self.key_name_in_response
		'hosts'
	end

	def self.quantity_of_hosts
		@@quantity +=1
		@@quantity
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
	@json_representation=json
	def initialize(json)
		@json_representation=json
	end

	def transform_to_pdm_representation
		"Atomic {
	        Name = FelixServer#{quantity_of_hosts}
	        Ports = 1 ; 0
	        Path = PhaseI/FelixServer.h
	        Description = If Scilab is configured as backed in the cmd line options, this model runs Scilab commands at Init, Exit and when receive events.\n
	        Graphic
	            {
	            Position = -9975 ; -12285
	            Dimension = 450 ; 435
	            Direction = Right
	            Color = 15
	            Icon = %sinks%scilab.ico
	            }
	        Parameters
	            {
	            Run at Init = Str; exec('../examples/Matias/PhaseI/Scilab/model.scilabParams', 0) ; Scilab Job at Init
	            Run at External = Str;  ; Scilab Job when receive event
	            Run at Exit = Str;  ; Scilab Job at Exit
	            }
        }"
	end
end