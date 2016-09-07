require 'json'
require 'typhoeus'
require 'rgl/adjacency'

response_hosts = Typhoeus.get('http://127.0.0.1:8181/onos/v1/hosts/',userpwd:"onos:rocks")
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
hosts = JSON.parse(response_hosts.body)['hosts']


response_devices = Typhoeus.get('http://127.0.0.1:8181/onos/v1/devices/',userpwd:"onos:rocks")

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
devices = JSON.parse(response_devices.body)['devices']


response_links = Typhoeus.get('http://127.0.0.1:8181/onos/v1/links/',userpwd:"onos:rocks")

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
links = JSON.parse(response_links.body)['links']

def buildGraphTopology(hosts,devices,links)
	my_direct_graph=RGL::DirectedAdjacencyGraph[]

	hosts.each do |host|
		my_direct_graph.add_vertex(host['id'])
	end

	devices.each do |device|	
		my_direct_graph.add_vertex(devices['id'])
	end

	
end