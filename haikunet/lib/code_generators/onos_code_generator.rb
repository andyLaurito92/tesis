require 'typhoeus'
require 'cgi'

module OnosCodeGenerator
    def generate_output
        code = ''
        @identifiers.each do |identifier|
            case identifier.value
            when Host
                host_params = get_host_params identifier
                next if is_defined_in_topology host_params
                code += "{
                    \"mac\" : \"#{host_params['mac']}\", \n
                    \"vlan\" : \"#{host_params['vlan']}\", \n
                    \"ipAddresses\" : #{host_params['ips']}, \n
                    \"location\" : {
                        \"elementId\" : #{host_params['elementId']}, \n
                        \"port\" : #{host_params['port']}
                    }
                }\n"
            when Flow
                flow_params = get_flow_params identifier
                code += "{
                          \"type\": \"HostToHostIntent\",
                          \"appId\": \"org.onosproject.ovsdb\",
                          \"priority\": #{flow_params['priority']},
                          \"one\": \"#{flow_params['src']}/-1\",
                          \"two\": \"#{flow_params['dst']}/-1\"
                        }
                      "
            end
        end
        code
    end

    def value_from(value_name, array)
        elem = array.select { |elem| elem.name == value_name }.first
        elem.nil? ? elem : elem.value
    end

    def get_host_params(host_identifier)
        mac = value_from 'mac', host_identifier.value.params
        vlan = value_from 'vlan', host_identifier.value.params
        ips = value_from 'ips', host_identifier.value.params
        elementId = value_from 'elementId', host_identifier.value.params
        port = value_from 'port', host_identifier.value.params

        {'mac' => mac, 'vlan' => vlan || -1, 'ips' => ips || '[]', 'elementId' => elementId || '', 'port' => port || ''}
    end

    def get_flow_params(flow_identifier)
        src = value_from 'src', flow_identifier.value.params
        src_mac = value_from 'mac', src.value.params
        dst = value_from 'dst', flow_identifier.value.params
        dst_mac = value_from 'mac', dst.value.params
        priority = value_from 'priority', flow_identifier.value.params

        {'src' => src_mac, 'dst' => dst_mac, 'priority' => priority}
    end

    def is_defined_in_topology(host_params)
        uri_resource = 'http://127.0.0.1:8181/onos/v1'
        response = Typhoeus.get "#{uri_resource}/hosts/#{CGI.escape(host_params['mac'])}/#{host_params['vlan']}", userpwd:"onos:rocks"
        response.code == 200
    end
end