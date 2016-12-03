require "ipaddress"
require_relative 'utils/custom_file_utils.rb'

class SemanticRulesChecker
    def check(context, topology_provider)
        @context = context
        @topology_provider = topology_provider
        @topology = @topology_provider.get_initial_topology

        hosts_are_well_defined

        flows_are_well_defined

        values_defined_in_flows_are_defined_in_topology

        paths_for_flows_exists
    end

    def hosts_are_well_defined

    end

    def flows_are_well_defined

    end

    def values_defined_in_flows_are_defined_in_topology
        hosts_in_topology = @topology.select{ |elem| elem.is_a? Host }
        flows_identifiers_defined = @context['identifiers'].select{ |identifier| identifier.value.is_a? HaikunetFlow }

        #If a HaikunetHost is used as parameter of the flow, then semantically is well 
        #constructed, since if the Host is not defined, it will be constructed first. (At this step 
        #we know that if the HaikunetHost is defined, then its already defined in some part
        #of the program)

        identifiers_in_flow_parameters = flows_parameters_of_type flows_identifiers_defined, String 
        identifiers_in_flow_parameters += (flows_parameters_of_type flows_identifiers_defined, Array)
        identifiers_in_flow_parameters = identifiers_in_flow_parameters.flatten

        identifiers_in_flow_parameters.each do |identifierValue|
            if IPAddress.valid? identifierValue
                check_if_property_exists_in_topology hosts_in_topology, identifierValue, lambda{|host, value| return true if host.ips.include? value }, "the ip #{identifierValue} is not defined in the initial topology provided."
            elsif  MacAddress.valid? identifierValue
                check_if_property_exists_in_topology hosts_in_topology, identifierValue, lambda{|host, value| return host.mac. == value}, "the mac #{identifierValue} is not defined in the initial topology provided."
            end
        end
    end

    def paths_for_flows_exists

    end


    def flows_parameters_of_type(flows, resource)
        resources = []
        flows.each do |flow_identifier|
            haikunet_flow_identifier = flow_identifier.value
            haikunet_flow_identifier.params.each do |identifier|
                resources.push identifier.value if identifier.value.is_a? resource #Because the first identifier is the tag
            end
        end
        resources
    end

    def check_if_property_exists_in_topology(hosts_in_topology, value, condition_to_check, error_message)
        hosts_in_topology.each do |host|
            return if condition_to_check.call host, value
        end
        raise_semantic_error error_message
    end

    def raise_semantic_error(message)
        raise SemanticalError, "A semantic error was found in one of the flow definitions. The problem is that #{message}\n Please correct this error in order to run the program ;)."
    end
end