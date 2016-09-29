require_relative 'command_line_arguments.rb'
require_relative 'lexer.rb'

class Haikunet
	def initialize
		my_command_line_arguments = CommandLineArguments.new
		my_command_line_arguments.run
		@program_lexeme = File.open(my_command_line_arguments.file_name).read
	end
	
	def tokenize
		my_lexer = Lexer.new @program_lexeme
		my_lexer.tokenize_lexeme
	end
end

my_haikunet_interpreter = Haikunet.new
my_haikunet_interpreter.tokenize