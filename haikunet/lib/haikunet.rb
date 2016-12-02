#!/usr/bin/env ruby

require 'colorize'
require 'topologygenerator'
require_relative 'command_line_arguments.rb'
require_relative 'lexer.rb'
require_relative 'parser.rb'
require_relative 'code_generator.rb'
require_relative 'utils/custom_file_utils.rb'

class Haikunet
    include CustomFileUtils
    
    def initialize
        my_command_line_arguments = CommandLineArguments.new
        my_command_line_arguments.run
        
        @file_name = my_command_line_arguments.file_name
        abort unless @file_name #User asked for help
        
        @program_lexeme = File.open(@file_name).read
        @destiny_name = my_command_line_arguments.destiny_name
        @uri_initial_topo = my_command_line_arguments.uri_initial_topo
    end
    
    def interpretate
        my_lexer = Lexer.new
        lexeme_tokenized = my_lexer.tokenize_lexeme @program_lexeme

        my_parser = Parser.new 
        parse_tree = my_parser.parse lexeme_tokenized
        
        topology_generator = Topologygenerator.new ({
            "source" => "ONOS",
            "directory_concrete_builders" => "#{File.dirname(File.realpath(__FILE__))}/haikunet_topology_generator_builder",
            "output_directory" => "lib/initial_topo",
            "uri_resource" => @uri_initial_topo 
        })
        topology_generator.generate

        #my_semantic_checker = SemanticRulesChecker.new
        #my_semantic_checker.check my_parser.context, initial_topology

        my_code_generator = CodeGenerator.new
        my_code_generator.generate_code my_parser.context, @destiny_name, @file_name        
    end
end

begin
    my_haikunet_interpreter = Haikunet.new
    my_haikunet_interpreter.interpretate 
rescue Exception => ex
  puts "#{ex.class}".red 
  puts "#{ex.message}".blue
end
    