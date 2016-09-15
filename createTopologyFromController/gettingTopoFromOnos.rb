require 'json'
require 'typhoeus'
require 'byebug'
require 'fileutils.rb'
require './pdm_constants.rb'
require './network_element.rb'
require './host.rb'
require './link.rb'
require './router.rb'
require 'rgl/adjacency'

def get_from_api(resource)
    Typhoeus.get "http://127.0.0.1:8181/onos/v1/#{resource}", userpwd:"onos:rocks"
end

def add_routers
    routers = []
    #Devices represents either hosts or routers. This function will make difference between them
    devices_response = get_from_api 'devices'
    graph_elements_info = (JSON.parse devices_response.body)['devices']
    graph_elements_info.each do |element_info|
        # To identify if a device is either a router or a host, we can ask for it flows. If the device has no flows, 
        # then it's a host
        flows_response = get_from_api "flows/#{element_info['id']}"
        routers.push Router.new element_info if flows_response.code == 200
    end
    routers
end

def add_hosts
    hosts = []
    hosts_response = get_from_api 'hosts'
    hosts_info = (JSON.parse hosts_response.body)['hosts']
    hosts_info.each do |host_info|
        hosts.push Host.new host_info
    end
    hosts
end

def add_links(graph_elements)
    links = []
    links_between_routers_response = get_from_api 'links'
    links_between_routers_info = (JSON.parse links_between_routers_response.body)['links']
    links_between_routers_info.each do |link_between_routers_info|
        links.push Link.new link_between_routers_info
    end

    links_between_routers_and_hosts = []
    hosts = graph_elements.select { |graph_element| graph_element.is_a? Host }
    hosts.each do |host|
        link_info = {
                        "src"=>{
                            "port"=>"2", 
                            "device"=>host.representation['id']
                        }, 
                        "dst"=>{
                            "port"=>host.representation['location']['port'], 
                            "device"=>host.representation['location']['elementId']
                        }, 
                        "type"=>"DIRECT", 
                        "state"=>"ACTIVE"
                    }
        links.push Link.new link_info
    end
    links
end

def pdm_position(node, number_of_pdm_models_in_structure)
    # The first 3 elements of the pdme are the 
    if node.is_a? Host
        number_of_pdm_models_in_structure + node.my_number
    elsif node.is_a? Router
        number_of_pdm_models_in_structure + Host.quantity + node.my_number 
    elsif node.is_a? Link
        number_of_pdm_models_in_structure + Host.quantity + Router.quantity + node.my_number 
    else
        raise Exception, "You should not be here"
    end
end

def create_lines_between_graph_elements(graph_elements, number_of_pdm_models_in_structure)
    links = graph_elements.select { |node| node.is_a? Link }
    lines = ''
    links.each do |link|
        src = graph_elements.select { |node| node.id == link.src['device'] }.first
        dst = graph_elements.select { |node| node.id == link.dst['device'] }.first
        lines += "Line
                {
                Source = Cmp ;  #{pdm_position src, number_of_pdm_models_in_structure} ;  1 ; 0
                Sink = Cmp ;  #{pdm_position link, number_of_pdm_models_in_structure} ;  1 ; -1
                PointX = -9675 ; -9675 ; -9675
                PointY = -10350 ; -10350 ; -9990
                }
                Line
                {
                Source = Cmp ;  #{pdm_position link, number_of_pdm_models_in_structure} ;  1 ; 0
                Sink = Cmp ;  #{pdm_position dst, number_of_pdm_models_in_structure} ;  1 ; -1
                PointX = -9675 ; -9675 ; -9675
                PointY = -10350 ; -10350 ; -9990
                }
                "
    end
    lines
end

def buildPDM(graph_elements,pdm_initial_structure, pdm_final_structure, number_of_pdm_models_in_structure)
    pdm_topology = pdm_initial_structure 
    
	graph_elements.each do |element|
        pdm_topology += element.transform_to_pdm_representation
    end
    
    pdm_topology += create_lines_between_graph_elements graph_elements, number_of_pdm_models_in_structure

    pdm_topology += pdm_final_structure

    open('my_topology.pdm', 'a') do |f|
      f.puts pdm_topology
    end

    pdm_topology
end

graph_elements = []

graph_elements += add_hosts

graph_elements += add_routers

graph_elements += add_links graph_elements

buildPDM graph_elements, PDM_INITIAL_STRUCTURE, PDM_FINAL_STRUCTURE, NUMBER_OF_PDM_MODELS_IN_STRUCTURE