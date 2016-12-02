 require "ipaddress"

class SemanticRulesChecker
    def check(context, topology_provider)
        @context = context
        @topology_provider = topology_provider
        @topology = @topology_provider.get_initial_topology

        #hosts_are_well_defined

        #flows_are_well_defined

        values_defined_in_flows_are_defined_in_topology

        paths_for_flows_exists
    end

    def values_defined_in_flows_are_defined_in_topology
        hosts_in_topology = @topology.select{ |elem| elem.is_a? Host }
        flows_identifiers_defined = @context['identifiers'].select{ |identifier| identifier.value.is_a? HaikunetFlow }

        #If a HaikunetHost is used as parameter of the flow, then semantically is well 
        #constructed, since if the Host is not defined, it will be define. (At this step 
        #we know that if the HaikunetHost is defined, then its already defined in some part
        #of the program)

        identifiers_in_flow_parameters = get_from_flows_parameters flows_identifiers_defined, String 
        identifiers_in_flow_parameters += (get_from_flows_parameters flows_identifiers_defined, Array)
        identifiers_in_flow_parameters = identifiers_in_flow_parameters.flatten

        identifiers_in_flow_parameters.each do |identifierValue|
            byebug
            if IPAddress.valid? identifierValue
                check_if_ip_exists hosts_in_topology, identifierValue
                break
            #elsif  MacAddress.valid?
            else
                raise_semantic_error "in a flow definition the value #{identifierValue} has no sense."
            end
        end

    end

    def paths_for_flows_exists

    end


    def get_from_flows_parameters(flows, resource)
        resources = []
        flows.each do |flow_identifier|
            haikunet_flow_identifier = flow_identifier.value
            haikunet_flow_identifier.params.each do |identifier|
                resources.push identifier.value if identifier.value.is_a? resource #Because the first identifier is the tag
            end
        end
        resources
    end

    def check_if_ip_exists(hosts_in_topology, value)
        hosts_in_topology.each do |host|
            return if host.id == value
        end

        raise_semantic_error "the ip #{value} is not defined in the initial topology provided."
    end

    def raise_semantic_error(message)
        raise SemanticalError, "A semantic error was found in one of the flow definitions. The problem is that #{message}\n Please correct this error in order to run the program ;)."
    end
end