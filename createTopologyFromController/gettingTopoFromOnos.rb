require 'json'
require 'typhoeus'
require 'host.rb'
require 'link.rb'
require 'device.rb'
require 'rgl/adjacency'

graph_elements = []
resources = [Host]

api_resources.each do |resource|
	response = Typhoeus.get(resource.uri_resource,userpwd:"onos:rocks")
  json_representation = JSON.parse response.body[resource.key_name_in_response]
  graph_elements.push resource.send(:new, json_representation)
end

def buildPDM
	graph_elements.each do |element|
    puts element.transform_to_pdm_representation
end

buildPDM