require 'commander'

class CommandLineArguments
    include Commander::Methods

    attr_reader :file_name

    def run
        program :name, 'Haikunet interpreter'
        program :version, '0.0.1'
        program :description, 'The interpreter for Haikunet programming language. Haikunet is a network intents programming language, 
        which is focused in making programmer\'s life easier.'
        program :help, 'Author', 'Andrés Laurito'

        my_command_line_argument = self 

        my_command = command :file_name do |c|
          c.syntax = 'haikunet program [OPTIONS]'
          c.summary = 'Specify the file name of the haikunet program'
          c.description = 'Specify the file name of the haikunet program'
          c.example 'Reading a file name called hellohaikunet.hk', 'haikunet progran -n hellohaikunet.hk'
          c.option '-n', '--name NAME', String, 'Specify the file name'
          c.action do |args, options|
            @file_name = options.name
            raise ArgumentError, "The file #{@file_name} does not exist. Please check that you provide the correct path." unless File.file?(filename)
            raise ArgumentError, "The interpreter only accepts files with the extension .hk, file name provided was #{@file_name}" unless ['.hk'].include? File.extname(@file_name)
          end
        end

    	run!
    end
end
