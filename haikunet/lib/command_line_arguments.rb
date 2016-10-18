require 'commander'

class CommandLineArguments
    include Commander::Methods

    attr_reader :file_name, :destiny_name

    def run
        program :name, 'Haikunet interpreter'
        program :version, '0.0.1'
        program :description, 'The interpreter for Haikunet programming language. Haikunet is a network intents programming language, which is focused in making programmer\'s life easier.'
        program :help, 'Author', 'Andrés Laurito'

        my_command_line_argument = self 

        my_command = command :program do |c|
          c.syntax = 'haikunet program [OPTIONS]'
          c.summary = 'Specify the file name of the haikunet program'
          c.description = 'Specify the file name of the haikunet program'
          c.example 'Interpretating a file called hellohaikunet.hk heading the output to ONOS', 'haikunet progran -n hellohaikunet.hk -d ONOS'
          c.example 'Interpretating the same file hellohaikunet.hk heading the output to DEVS', 'haikunet progran -n hellohaikunet.hk -d DEVS'
          c.option '-n', '--name NAME', String, 'Specify the file name'
          c.option '-d', '--destiny NAME', String, 'Specify the current destiny for the intent. Haikunet currently support for ONOS and DEVS'
          c.action do |args, options|
            @file_name = options.name
            @destiny_name = options.destiny
            raise ArgumentError, "The file #{@file_name} does not exist. Please check that you provide the correct path." unless File.file?(@file_name)
            raise ArgumentError, "The destiny #{@destiny_name} was not provided. Please select one of the currently supported (haikunet --help to see currently suported destinies)." unless @destiny_name
            raise ArgumentError, "The destiny provided was #{destiny_name} which is not one of the supported by Haikunet. Please select one of the currently supported (haikunet --help to see currently suported destinies)." unless ['OPENDAYLIGHT', 'ONOS', 'DEVS'].include? @destiny_name
            raise ArgumentError, "The interpreter only accepts files with the extension .hk, file name provided was #{@file_name}" unless ['.hk'].include? File.extname(@file_name)
          end
        end

    	run!
    end
end
