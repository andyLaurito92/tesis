require 'json'
require 'typhoeus'
require 'byebug'
require 'fileutils.rb'
require './host.rb'
require './link.rb'
require './device.rb'
require 'rgl/adjacency'

graph_elements = []
resources = [Link]

resources.each do |resource|
    response = Typhoeus.get(resource.uri_resource,userpwd:"onos:rocks")
    json_repres_of_graph_elements = (JSON.parse response.body)[resource.key_name_in_response]
    json_repres_of_graph_elements.each do |json_representation|
        graph_elements.push resource.send(:new, json_representation)
    end
end

def buildPDM(graph_elements)
    pdm_topology = 'Coupled
    {
        Type = Root
        Name = MyTopology
        Ports = 0; 0
        Description = Testing the creation of a topology by getting the info from the controller
        Graphic
            {
                Position = 0; 0
                Dimension = 600; 600
                Direction = Right
                Color = 15
                Icon = 
                Window = 5000; 5000; 5000; 5000
            }
        Parameters
            {
            }
        System
            {
                ' 
	graph_elements.each do |element|
        pdm_topology += element.transform_to_pdm_representation
    end
    
    pdm_topology += '}
    }'

    open('my_topology.pdm', 'a') do |f|
      f.puts pdm_topology
    end

    pdm_topology
end

buildPDM(graph_elements)