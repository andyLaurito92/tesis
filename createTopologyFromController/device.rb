class Device
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
	@json_representation=json
	def initialize(json)
		@json_representation=json
	end


end