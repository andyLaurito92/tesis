class Lexer
	attr_reader :current_token, :program_lexeme
	def initialize(program_lexeme)
		@program_lexeme = program_lexeme
		
	end
end