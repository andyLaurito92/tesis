require 'json'
require 'typhoeus'
require 'byebug'
require 'fileutils.rb'
require './pdm_constants.rb'
require './network_element.rb'
require './host.rb'
require './link.rb'
require './device.rb'
require 'rgl/adjacency'

graph_elements = []
resources = [Host, Device, Link]

resources.each do |resource|
    response = Typhoeus.get(resource.uri_resource,userpwd:"onos:rocks")
    json_repres_of_graph_elements = (JSON.parse response.body)[resource.key_name_in_response]
    json_repres_of_graph_elements.each do |json_representation|
        graph_elements.push resource.send(:new, json_representation)
    end
end

def buildPDM(graph_elements,pdm_initial_structure,pdm_final_structure)
    pdm_topology = pdm_initial_structure 
    
	graph_elements.each do |element|
        pdm_topology += element.transform_to_pdm_representation
    end
    
    pdm_topology += pdm_final_structure

    open('my_topology.pdm', 'a') do |f|
      f.puts pdm_topology
    end

    pdm_topology
end

buildPDM(graph_elements,PDM_INITIAL_STRUCTURE,PDM_FINAL_STRUCTURE)