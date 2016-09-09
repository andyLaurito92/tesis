class Link
	def self.uri_resource
		'http://127.0.0.1:8181/onos/v1/links/'
	end

	def self.key_name_in_response
		'links'
	end

=begin
links is an array of elements of this kind
{
	"src"=>{
		"port"=>"2", 
		"device"=>"of:0000000000000001"
	}, 
	"dst"=>{
		"port"=>"3", 
		"device"=>"of:0000000000000005"
	}, 
	"type"=>"DIRECT", 
	"state"=>"ACTIVE"
}
=end
	@json_representation=json
	def initialize(json)
		@json_representation=json
	end


end