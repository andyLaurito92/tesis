class Lexer
	attr_reader :current_token, :program_lexeme
	def initialize(program_lexeme)
		@program_lexeme = program_lexeme
	end

    def tokenize_lexeme
        program_lexeme_lines = @program_lexeme.gsub(/\r\n?/, "\n")
        line_number = 0
        program_lexeme_lines.each_line do |line|
            line
            line_number += 1
        end
    end
end