require 'byebug'
require_relative 'tokens.rb'

class Lexer
	attr_reader :current_token, :program_lexeme, :tokens_table
	def initialize(program_lexeme)
		@program_lexeme = program_lexeme
        @program_lexeme_lines = @program_lexeme.gsub(/\r\n?/, "\n")
        @tokens_table
	end

    def tokenize_lexeme
        line_number = 0
        @program_lexeme_lines.each_line do |line|
            byebug
            puts "#{line_number} : #{line}"
            line_number += 1
        end
    end
end