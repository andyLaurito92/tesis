module OnosCodeGenerator
    def generate_output
        code = ''
        @identifiers.each do |identifier|
            case identifier.value
            when Host
                host_params = identifier.value.params
                mac = value_from 'mac', host_params
                code += "{
                    \"id\" : \"#{identifier.name}\", \n
                    \"mac\" : \"#{mac}\"
                }\n"
            when Flow
                flow_params = identifier.value.params
                src = value_from 'src', flow_params
                dst = value_from 'dst', flow_params
                priority = value_from 'priority', flow_params
                code += "{
                      \"flows\": [
                        {
                          \"priority\": #{priority},
                          \"timeout\": 0,
                          \"isPermanent\": true,
                          \"deviceId\": \"of:0000000000000001\",
                          \"treatment\": {
                            \"instructions\": [
                              {
                                \"type\": \"OUTPUT\",
                                \"port\": \"CONTROLLER\"
                              }
                            ]
                          },
                          \"selector\": {
                            \"criteria\": [
                              {
                                \"type\": \"ETH_TYPE\",
                                \"ethType\": \"0x88cc\"
                              }
                            ]
                          }
                        }
                      ]
                    }"
            end
        end

        @intents.each do |intent|
            flow_params = intent.select.value.params
            src = value_from 'src', flow_params
            dst = value_from 'dst', flow_params
            code += "{
                    \"type\" : \"HostToHostIntent\", \n
                    \"appId\" : \"#{intent.name}\", \n
                    \"one\" : \"#{src}\", \n
                    \"two\" : \"#{dst}\"\n
                }\n"
        end
        code
    end

    def value_from(value_name, array)
        array.select { |elem| elem.name == value_name }.first.value
    end
end