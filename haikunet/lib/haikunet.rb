require_relative 'command_line_arguments.rb'
require_relative 'lexer.rb'
require_relative 'parser.rb'
require_relative 'semantic_analyzer.rb'

class Haikunet
    def initialize
        my_command_line_arguments = CommandLineArguments.new
        my_command_line_arguments.run
        @program_lexeme = File.open(my_command_line_arguments.file_name).read
        @destiny_name = my_command_line_arguments.destiny_name
    end
    
    def interpretate
        my_lexer = Lexer.new
        lexeme_tokenized = my_lexer.tokenize_lexeme @program_lexeme

        my_parser = Parser.new 
        parse_tree = my_parser.parse lexeme_tokenized
        
        byebug
        #my_semantic_checker = SemanticRulesChecker.new
        #my_semantic_checker.check interpretetated_program

        my_semantic_analyzer = SemanticAnalyzer.new
        interpretetated_program = my_semantic_analyzer.generate_intermediate_code_from my_parser.context
    end
end

my_haikunet_interpreter = Haikunet.new
my_haikunet_interpreter.interpretate 